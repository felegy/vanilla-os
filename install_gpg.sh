NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
/home/linuxbrew/.linuxbrew/bin/brew install gpg git
for i in /home/linuxbrew/.linuxbrew/bin/*; do 
    ln -sn $i /usr/local/bin/ 
done


