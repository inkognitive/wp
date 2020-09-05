#!/bin/bash
#Download wp-cli
wget -qP ~ https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
#Check if WordPress is installed
echo
site=$(ls | grep wp-config.php); if  [[ -z "${site}" ]]
then
        echo 'No WP installation found'
elif [[ -f "${site}" ]]
then
        echo "WordPress $(php ~/wp-cli.phar core version) is installed"
#Check if the files are hacked
 echo $(php ~/wp-cli.phar core verify-checksums)

#Replace the core files
while true; do
    read -p "Are you sure you wish to replace core files? " yn
    case $yn in
        [Yy]* ) for i in $(php ~/wp-cli.phar core version); do rm -rf index.php wp-activate.php wp-blog-header.php wp-comments-post.php wp-cron.php wp-links-opml.php wp-load.php wp-login.php wp-settings.php wp-signup.php wp-trackback.php xmlrpc.php wp-mail.php wp-admin/ wp-includes/ && echo 'Core files removed' ; php ~/wp-cli.phar core download --version=$i ; echo 'Core downloaded'; done; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
#Correct permissions
#find -type f | xargs chmod 644 2> /dev/null  ; find -type d | xargs chmod 755 2> /dev/null ; chmod 750 . -c 2> /dev/null ; echo "Permissions corrected"
echo $(php ~/wp-cli.phar core verify-checksums)
#Removewp-cli
rm -rf ~/wp-cli.phar  ~/.wp-cli/
fi
exit 0
