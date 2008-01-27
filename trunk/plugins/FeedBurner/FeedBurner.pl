# ===========================================================================
# Copyright Everitz Consulting.  Not for redistribution.
# ===========================================================================
package MT::Plugin::FeedBurner;

use base qw(MT::Plugin);
use strict;

use MT;
use MT::Util qw(dirify mark_odd_rows);

my $FeedBurner;
$FeedBurner = MT::Plugin::FeedBurner->new({
  name => 'MT-FeedBurner',
  description => "<MT_TRANS phrase=\"Connect your RSS feed to FeedBurner.\">",
  author_name => 'Everitz Consulting',
  author_link => 'http://www.everitz.com/',
  plugin_link => 'http://www.everitz.com/sol/mt-feedburner/index.php',
  doc_link => 'http://www.everitz.com/sol/mt-feedburner/index.php#install',
  l10n_class => 'FeedBurner::L10N',
  version => '1.0.0',
});
MT->add_plugin($FeedBurner);

MT->add_callback('MT::App::CMS::AppTemplateSource.list_template', 1, $FeedBurner, \&source_list_template);

# plugin initialization

sub init_app {
  my $plugin = shift;
  my ($app) = @_;
  return unless ($app->isa('MT::App::CMS'));
  $app->add_methods(
    feedburner_connect => sub { feedburner_connect($plugin, @_) },
    feedburner_configure => sub { feedburner_configure($plugin, @_) },
    feedburner_signup => sub { feedburner_signup($plugin, @_) }
  );
}

sub instance { $FeedBurner }

# functions

sub feedburner_configure {
  my $plugin = shift;
  my $app = shift;
  my($param) = @_;
  my $blog_id = $app->param('blog_id');
  my $tmpl_id = $app->param('tmpl_id');

  my %param = ();
  $param{'blog_id'} = $blog_id;
  $param{'tmpl_id'} = $tmpl_id;
  $param{'feedburner_username'} = $app->param('feedburner_username') || '';

  require MT::Blog;
  my $blog = MT::Blog->load($blog_id);
  my $blog_name = $blog->name || '';
  my $blog_url = $blog->site_url;
  unless ($blog_url =~ m!/$!) {
    $blog_url = $blog_url . '/';
  }

  my $smode = $app->param('__smode') || 'signup';
  my $template = 'feedburner_' . $smode . '.tmpl';
  my $fburlbase = 'http://feeds.feedburner.com/';

  if ($smode eq 'select') {
    my $username = $app->param('feedburner_username') || '';
    my $password = $app->param('feedburner_password') || '';
    require Net::FeedBurner;
    my $feedburner = Net::FeedBurner->new(
      'user' => $username,
      'password' => $password
    );
    my ($feeds, @fbfeeds);
    eval { $feeds = $feedburner->find_feeds(); };
    if ($@) {
      $template = 'feedburner_signup.tmpl';
      $param{'error_no_match'} = 1;
    } else {
      if (keys %{$feeds}) {
        my $FeedBurner = MT::Plugin::FeedBurner->instance;
        $FeedBurner->set_config_value("template_username_$tmpl_id", $username, 'blog:'.$blog_id);
        $FeedBurner->set_config_value("template_password_$tmpl_id", $password, 'blog:'.$blog_id);
        map { push @{ $param{'feedburner_feeds'} }, $feeds->{$_} } keys %{ $feeds };
        $param{'feedburner_feeds'} = [ sort { $a->{'title'} cmp $b->{'title'} } @{$param{'feedburner_feeds'} || []} ];
        mark_odd_rows($param{'feedburner_feeds'});
      } else {
        $template = 'feedburner_create.tmpl';
        $param{'feedname'} = $blog_name;
        $param{'feedurl'} = dirify($blog_name);
        $param{'no_feeds'} = 1;
      }
    }
  }

  if ($smode eq 'confirm') {
    if ($app->param('id') eq '0') {
      $template = 'feedburner_create.tmpl';
      $param{'feedname'} = $blog_name;
      $param{'feedurl'} = dirify($blog_name);
    } else {
      my $FeedBurner = MT::Plugin::FeedBurner->instance;
      my $username = $FeedBurner->get_config_value("template_username_$tmpl_id", 'blog:'.$blog_id);
      my $password = $FeedBurner->get_config_value("template_password_$tmpl_id", 'blog:'.$blog_id);
      my $feed_id = $app->param('id');
      my $feedinfo;
      require Net::FeedBurner;
      my $feedburner = Net::FeedBurner->new(
        'user' => $username,
        'password' => $password
      );
      eval { $feedinfo = $feedburner->get_feed($feed_id); };
      if ($feedinfo) {
        require MT::Template;
        my $tmpl = MT::Template->load($tmpl_id);
        if ($tmpl && $tmpl->outfile) {
          eval { $feedburner->modify_feed_source($feed_id, $blog_url . $tmpl->outfile); };
          if ($@) {
            $template = 'feedburner_select.tmpl';
            $param{'error_setting'} = 1;
          } else {
            $param{'feed_id'} = $feed_id;
          }
        } else {
          $template = 'feedburner_select.tmpl';
          $param{'error_setting'} = 1;
        }
      } else {
        $template = 'feedburner_select.tmpl';
        $param{'error_setting'} = 1;
      }
    }
  }

  if ($smode eq 'confirm_create') {
    $template = 'feedburner_confirm.tmpl';
    if ($app->param('feedurl') && $app->param('feedname')) {
      my $FeedBurner = MT::Plugin::FeedBurner->instance;
      my $username = $FeedBurner->get_config_value("template_username_$tmpl_id", 'blog:'.$blog_id);
      my $password = $FeedBurner->get_config_value("template_password_$tmpl_id", 'blog:'.$blog_id);
      require Net::FeedBurner;
      my $feedburner = Net::FeedBurner->new(
        'user' => $username,
        'password' => $password
      );
      require MT::Template;
      my $tmpl = MT::Template->load($tmpl_id);
      if ($tmpl && $tmpl->outfile) {
        my $feed;
        my $feedinfo = '<feed uri="' . $app->param('feedurl') . '" title="' . $app->param('feedname') . '"><source url="' . $blog_url . $tmpl->outfile . '"/><services><service class="ItemStats" /><service class="SmartFeed" /><service class="BrowserFriendly"><param name="style">new</param></service></services></feed>';
        eval { $feed = $feedburner->add_feed($feedinfo); };
        if ($@) {
          $template = 'feedburner_create.tmpl';
          $param{'feedname'} = $blog_name;
          $param{'feedurl'} = dirify($blog_name);
          $param{'error_taken'} = 1;
        } else {
          $param{'feed_id'} = $feed->{'id'};
          $param{'feed_ok'} = 1;
        }
      } else {
        $template = 'feedburner_select.tmpl';
        $param{'error_setting'} = 1;
      }
    } else {
      $template = 'feedburner_create.tmpl';
      $param{'feedname'} = $blog_name;
      $param{'feedurl'} = dirify($blog_name);
      $param{'error_incomplete'} = 1;
    }
  }

  if ($smode eq 'done') {
    if ($app->param('feed_redirect')) {
      my $FeedBurner = MT::Plugin::FeedBurner->instance;
      my $username = $FeedBurner->get_config_value("template_username_$tmpl_id", 'blog:'.$blog_id);
      my $password = $FeedBurner->get_config_value("template_password_$tmpl_id", 'blog:'.$blog_id);
      my $feed_id = $app->param('feed_id');
      my $feedinfo;
      require Net::FeedBurner;
      my $feedburner = Net::FeedBurner->new(
        'user' => $username,
        'password' => $password
      );
      eval { $feedinfo = $feedburner->get_feed($feed_id); };
      if ($feedinfo) {
        $FeedBurner->set_config_value("template_username_$tmpl_id", '', 'blog:'.$blog_id);
        $FeedBurner->set_config_value("template_password_$tmpl_id", '', 'blog:'.$blog_id);
        my $feedburner_url = 'http://feeds.feedburner.com/' . $feedinfo->{'uri'};
        require MT::Template;
        my $tmpl = MT::Template->load($tmpl_id);
        if ($tmpl && $tmpl->outfile) {
          unless (update_htaccess($blog_id, $tmpl_id, $tmpl->outfile, $feedburner_url)) {
            $param{'error_no_htaccess'} = 1;
          }
        } else {
          $param{'error_no_htaccess'} = 1;
        }
      } else {
        $param{'error_no_htaccess'} = 1;
      }
    }
  }

  $app->{cfg}->AltTemplatePath(MT::Plugin::FeedBurner->instance->envelope.'/tmpl/');
  $app->build_page($template, \%param);
}

sub feedburner_connect {
  my $plugin = shift;
  my $app = shift;
  my $blog_id = $app->param('blog_id');

  my @feeds;
  # find possible rss templates (indexes only)
  require MT::Template;
  my @tmpl = grep { ($_->name =~ /(atom|rss)/i) || ($_->outfile =~ /\.(xml|rdf|rss)$/i && $_->outfile !~ /^rsd/i) } MT::Template->load ({ blog_id => $blog_id, type => 'index' });
  foreach my $tmpl (@tmpl) {
    push @feeds, {
      feed_template_id => $tmpl->id,
      feed_template_name => $tmpl->name
    }
  }

  my %param;
  $param{'blog_id'} = $blog_id;
  $param{feed_template_loop} = \@feeds;
  $app->{cfg}->AltTemplatePath(MT::Plugin::FeedBurner->instance->envelope.'/tmpl/');
  $app->build_page('feedburner_connect.tmpl', \%param);
}

sub feedburner_signup {
  my $plugin = shift;
  my $app = shift;
  my $blog_id = $app->param('blog_id');
  my $tmpl_id = $app->param('tmpl_id');

  my %param;
  $param{'blog_id'} = $blog_id;
  $param{'tmpl_id'} = $tmpl_id;

  if ($param{'tmpl_id'}) {
    $app->{cfg}->AltTemplatePath(MT::Plugin::FeedBurner->instance->envelope.'/tmpl/');
    $app->build_page('feedburner_signup.tmpl', \%param);
  } else {
    my @feeds;
    # find possible rss templates (indexes only)
    require MT::Template;
    my @tmpl = grep { ($_->name =~ /(atom|rss)/i) || ($_->outfile =~ /\.(xml|rdf|rss)$/i && $_->outfile !~ /^rsd/i) } MT::Template->load ({ blog_id => $blog_id, type => 'index' });
    foreach my $tmpl (@tmpl) {
      push @feeds, {
        feed_template_id => $tmpl->id,
        feed_template_name => $tmpl->name
      }
    }
    $param{feed_template_loop} = \@feeds;
    $app->{cfg}->AltTemplatePath(MT::Plugin::FeedBurner->instance->envelope.'/tmpl/');
    $app->build_page('feedburner_connect.tmpl', \%param);
  }
}

# redirect

sub update_htaccess {
  my ($blog_id, $tmpl_id, $tmpl_outfile, $feed_url) = @_;
  my (@in, @out);

  require MT::Blog;
  my $blog = MT::Blog->load($blog_id);
  unless ($blog) {
    return 0;
  }

  my $x;
  my $htaccess = File::Spec->catfile($blog->site_path(), '.htaccess');
  open (ONE, $htaccess) || die "($htaccess) Open Failed: $!\n";
  while (<ONE>) {
    if ($x) {
      $x--;
      next;
    }
    if ($_ =~ m!### MT-FeedBurner (Blog: $blog_id, Template: $tmpl_id) ###!) {
      $x = 7;
      next;
    }
    push @out, $_;
  }
  close (ONE);

  $tmpl_outfile =~ s!\.!\\\.!;
  push @out, '### MT-FeedBurner (Blog: '.$blog_id.', Template: '.$tmpl_id.') ###'."\n";
  push @out, '<IfModule mod_rewrite.c>'."\n";
  push @out, 'RewriteEngine on'."\n";
  push @out, 'RewriteCond %{HTTP_USER_AGENT} !FeedBurner'."\n";
  push @out, 'RewriteRule ^'.$tmpl_outfile.'$ '.$feed_url.' [L,R=302]'."\n";
  push @out, 'RewriteEngine off'."\n";
  push @out, '</IfModule>'."\n";
  push @out, '### MT-FeedBurner (Blog: '.$blog_id.', Template: '.$tmpl_id.') ###'."\n";

  open (TWO, ">$htaccess") || die "($htaccess) Open Failed: $!\n";
  foreach my $line (@out) {
    print TWO $line;
  }
  close (TWO);

  return 1;
}

sub source_list_template {
  my ($cb, $app, $template) = @_;
  my ($new, $old);

  my $blog_id = $app->param('blog_id');
  my $cfg = MT::ConfigMgr->instance;
  my $fb = MT::Plugin::FeedBurner->instance;
  my $fb_base =($cfg->CGIPath =~ /^http/) ? $cfg->CGIPath : $app->base.$cfg->CGIPath;
  my $fb_link = $fb_base.$cfg->AdminScript.'?__mode=feedburner_connect&amp;blog_id='.$blog_id;

  $old = qq{<TMPL_INCLUDE NAME="footer.tmpl">};
  $old = quotemeta($old);
  $new = <<HTML;
<div class="box" id="application-actions-box" style="border-bottom: 1px solid #c7d7df;">
<h4 style="background-color: #c7d7df; color: #333;"><MT_TRANS phrase="Application Actions"></h4>
<div class="inner" style="padding: 0 10px;">
<ul>
<li><a href="$fb_link" onclick="window.open('$fb_link', 'enable_feedburner', 'width=420,height=400,scrollbars=yes'); return false"><MT_TRANS phrase="Burn a feed using MT-FeedBurner"></a></li>
</ul>
</div>
</div>

<TMPL_INCLUDE NAME="footer.tmpl">
HTML
  $$template =~ s/$old/$new/;
}

1;
