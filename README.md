# SoundLove
SoundLove is Tinder for Soundcloud. Log in with your Soundcloud account, random (Like, seriously random... And weird.) SoundCloud sounds will begin to play,
 and you can like or pass on a song. Like a song, and it will add it to your SoundLove playlist. Pass on it, and it's "Gone with the Wind."

Gems being used: Soundcloud, Devise, Omniauth, Omniauth-soundcloud

#### To get this runing:

1. Create a Soundcloud account, set up project in Soundcloud Dev.
2. Set your Redirect URI as "http://localhost:3000/users/auth/soundcloud/callback"
3. Set up environment variables in .bashrc for SOUNDCLOUD_CLIENT_ID and SOUNDCLOUD_SECRET
4. Run 'rake db:migrate'
5. Run 'rails s' and you should be good to go!

#### Current Problems/Future Additions:
1. Soundcloud API doesn't provide access to e-mail. Great. If you sign up and sign out you wont be able to sign back in due to e-mail validation problems. Fixable, but not a top priority for demoing. (Self-note: This is because I began to work with identities then scrapped it. Future fix: Add identities by UID/Provider)
2. It finds some really strange music. Maybe write an algorithm to find new tracks based off favorites. (I have recently found some amazing tracks though.)
3. Allow the option to finish a song before loading the next.