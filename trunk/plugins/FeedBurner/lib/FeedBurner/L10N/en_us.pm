# ===========================================================================
# Copyright Everitz Consulting.  Not for redistribution.
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
	'Check the box if you would like to automatically redirect your source feed to FeedBurner (Not available on all systems):' => 'Check the box if you would like to automatically redirect your source feed to FeedBurner (Not available on all systems):',
	'Cancel' => 'Cancel',
	'Continue' => 'Continue',
	
	## feedburner_connect.tmpl
	'You must choose a source feed to connect to FeedBurner. Please try again.' => 'You must choose a source feed to connect to FeedBurner. Please try again.',
	'Select Source Feed' => 'Select Source Feed',
	'Choose the source feed from the drop-down list.' => 'Choose the source feed from the drop-down list.',
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
	'Your FeedBurner feed settings have been saved and will take effect immediately.' => 'Your FeedBurner feed settings have been saved and will take effect immediately.',
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
	'Username:' => 'Username:',
	'Password:' => 'Password:',
	'Connect to FeedBurner' => 'Connect to FeedBurner',
	'Click the &#8220;Sign In&#8221; button to connect to FeedBurner.' => 'Click the &#8220;Sign In&#8221; button to connect to FeedBurner.',
	'Sign In' => 'Sign In',

);

1;