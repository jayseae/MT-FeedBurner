# ===========================================================================
# A Movable Type plugin to connect your RSS feed to FeedBurner.
# Copyright 2007 Everitz Consulting <everitz.com>.
#
# This program is free software:  You may redistribute it and/or modify it
# it under the terms of the Artistic License version 2 as published by the
# Open Source Initiative.
#
# This program is distributed in the hope that it will be useful but does
# NOT INCLUDE ANY WARRANTY; Without even the implied warranty of FITNESS
# FOR A PARTICULAR PURPOSE.
#
# You should have received a copy of the Artistic License with this program.
# If not, see <http://www.opensource.org/licenses/artistic-license-2.0.php>.
# ===========================================================================
package FeedBurner::L10N::en_us;

use strict;
use base 'FeedBurner::L10N';
use vars qw( %Lexicon );

## If you want to create a new translation, follow these six steps:
##
## - Copy this file to <lowercase language code>.pm
##
## - Replace the "package" line with:
## package FeedBurner::L10N::<lowercase language code>;
##
## - Replace the "use base" line with:
## use base 'FeedBurner::L10N::en_us';
##
## - Change the replacement text as needed (the right side of "=>").
##
## - Send me a copy so I can distribute to others.
##
## - Save and upload to your server.  You're done.

## Tips for a successful translation:
##
## Make sure each line ends with a comma (,)
##
## If a variable such as [_1] is present, do not remove it
##
## Try to use HTML entities where possible (&uuml; instead of ü)
##
## Do not change the English (left) side of the translation string
##
## Any quotes within strings must be "escaped" to be included: 'This is a quote: \''

## The following is the translation table.

%Lexicon = (
	
	## FeedBurner.pl
	'Connect your RSS feed to FeedBurner.' => 'Connect your RSS feed to FeedBurner.',
	'Application Actions' => 'Application Actions',
	'Burn a feed using MT-FeedBurner' => 'Burn a feed using MT-FeedBurner',
	
	## feedburner_confirm.tmpl
	'Redirect Source Feed' => 'Redirect Source Feed',
	'If you would like to automatically redirect your source feed to FeedBurner, check this box (Not available on all systems):' => 'If you would like to automatically redirect your source feed to FeedBurner, check this box (Not available on all systems):',
	'Redirect all available index feeds, not just the source feed:' => 'Redirect all available index feeds, not just the source feed:',
	'Automatic redirection will not always work, as it is only intended for systems that use Apache with mod_rewrite and .htaccess.  This is because there are a number of systems - notably Windows using IIS - that may not support the rewriting method used here.' => 'Automatic redirection will not always work, as it is only intended for systems that use Apache with mod_rewrite and .htaccess.  This is because there are a number of systems - notably Windows using IIS - that may not support the rewriting method used here.',
	'If you still choose to select automatic redirection, you may also choose to redirect <em>all</em> available feeds to the target FeedBurner feed.  This means that a request for any of those feeds will be detected and be sent to your new FeedBurner feed location.' => 'If you still choose to select automatic redirection, you may also choose to redirect <em>all</em> available feeds to the target FeedBurner feed.  This means that a request for any of those feeds will be detected and be sent to your new FeedBurner feed location.',
	'Repeated redirection may introduce complexities into your system that could result in system instability, so you may wish to do this work manually.  FeedBurner has a thorough (but lengthy)' => 'Repeated redirection may introduce complexities into your system that could result in system instability, so you may wish to do this work manually.  FeedBurner has a thorough (but lengthy)',
	'on the subject for your reading pleasure.' => 'on the subject for your reading pleasure.',
	'Cancel' => 'Cancel',
	'Continue' => 'Continue',
	
	## feedburner_connect.tmpl
	'You must choose a source feed to connect to FeedBurner. Please try again.' => 'You must choose a source feed to connect to FeedBurner. Please try again.',
	'Select Source Feed' => 'Select Source Feed',
	'Choose a feed to use as a content source for your FeedBurner feed.' => 'Choose a feed to use as a content source for your FeedBurner feed.',
	'Your FeedBurner feed will connect to this source feed automatically.' => 'Your FeedBurner feed will connect to this source feed automatically.',
	'Source:' => 'Source:',
	'Connect' => 'Connect',
	
	## feedburner_create.tmpl
	'Please make sure you provide a name and complete the address for the new feed before continuing.' => 'Please make sure you provide a name and complete the address for the new feed before continuing.',
	'Sorry, the feed address you've requested is either invalid or already taken by a FeedBurner user. Please try another address.' => 'Sorry, the feed address you've requested is either invalid or already taken by a FeedBurner user. Please try another address.',
	'Create a New Feed' => 'Create a New Feed',
	'Enter a name and address for your new FeedBurner feed. Your feed address needs to be unique across all FeedBurner users, so you may want to get creative.' => 'Enter a name and address for your new FeedBurner feed. Your feed address needs to be unique across all FeedBurner users, so you may want to get creative.',
	'Make sure that the address does not contain any spaces in it (underscores work well to replace spaces, if you don't want to push all the words together).' => 'Make sure that the address does not contain any spaces in it (underscores work well to replace spaces, if you don't want to push all the words together).',
	'Name:' => 'Name:',
	'Address:' => 'Address:',
	
	## feedburner_done.tmpl
	'We were unable to automatically create a redirect to your selected feed. Please create it manually.' => 'We were unable to automatically create a redirect to your selected feed. Please create it manually.',
	'Configuration Complete' => 'Configuration Complete',
	'This is the address of your feed source.' => 'This is the address of your feed source.',
	'This is the address of your FeedBurner feed.' => 'This is the address of your FeedBurner feed.',
	'If you chose to redirect your existing feed(s) to the new FeedBurner feed, then your current readers will be redirected automatically.  Otherwise, you should now manually create the redirect using the information above.' => 'If you chose to redirect your existing feed(s) to the new FeedBurner feed, then your current readers will be redirected automatically.  Otherwise, you should now manually create the redirect using the information above.',
	'Close' => 'Close',
	
	## feedburner_select.tmpl
	'Please make sure you select an existing feed or choose to create a new feed before continuing.' => 'Please make sure you select an existing feed or choose to create a new feed before continuing.',
	'Sorry, there was an error mapping the source feed to the selected FeedBurner feed.  You can try again later, try another selection, or create a new feed.  If you have access to your Movable Type Activity Log, you should look there to try and determine a more detailed cause for this error before continuing.' => 'Sorry, there was an error mapping the source feed to the selected FeedBurner feed.  You can try again later, try another selection, or create a new feed.  If you have access to your Movable Type Activity Log, you should look there to try and determine a more detailed cause for this error before continuing.',
	'Select a Feed' => 'Select a Feed',
	'You can either connect your weblog to one of your existing feeds you manage at FeedBurner, or create a new feed at FeedBurner.' => 'You can either connect your weblog to one of your existing feeds you manage at FeedBurner, or create a new feed at FeedBurner.',
	'Feed Name' => 'Feed Name',
	'Create a new FeedBurner feed' => 'Create a new FeedBurner feed',
	
	## feedburner_signup.tmpl
	'We were unable to find a FeedBurner account which matches the provided username and password. Please try again.' => 'We were unable to find a FeedBurner account which matches the provided username and password. Please try again.',
	'Set FeedBurner Credentials' => 'Set FeedBurner Credentials',
	'Enter your FeedBurner username and password below.' => 'Enter your FeedBurner username and password below.',
	'The account must already exist at FeedBurner.' => 'The account must already exist at FeedBurner.',
	'Username:' => 'Username:',
	'Password:' => 'Password:',
	'Connect to FeedBurner' => 'Connect to FeedBurner',
	'Click the &#8220;Sign In&#8221; button to connect to FeedBurner.' => 'Click the &#8220;Sign In&#8221; button to connect to FeedBurner.',
	'Sign In' => 'Sign In',

);

1;