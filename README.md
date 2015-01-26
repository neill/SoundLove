# SoundLove
SoundLove is Tinder for Soundcloud. Log in with your Soundcloud account, random SoundCloud sounds will begin to play,
 and you can like or pass on a song. Like a song, and it will add it to your latest playlist. Pass on it, and it's "Gone with the Wind."

Gems being used: Devise, Omniauth, Omniauth-soundcloud

#### To get this runing:

1. Create a Soundcloud account, set up project in Soundcloud Dev.
2. Set your Redirect URI as "http://localhost:3000/users/auth/soundcloud/callback"
3. Set up environment variables in .bashrc for SOUNDCLOUD_CLIENT_ID and SOUNDCLOUD_SECRET
4. Run 'rake db:migrate'
5. Run 'rails s' and you should be good to go!

#### Current Problems:
1. Soundcloud API doesn't provide and e-mail. Great. If you sign up and sign out you wont be able to sign back in due to e-mail validation problems. Fixable, but not a top priority for demoing.