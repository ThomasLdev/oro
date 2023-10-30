cd /var/www/html/
export COMPOSER_PROCESS_TIMEOUT=6000
composer config -g github-oauth.github.com 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 
composer create-project oro/commerce-crm-application pepsneir 5.1.0 
cd pepsneir 
php bin/console oro:install -vvv --drop-database --sample-data=y --application-url=http://bas-hlakrout.app.norsys.fr/  --user-name=admin --user-email=admin@example.com --user-firstname=John --user-lastname=Doe --user-password=admin --organization-name=Oro --timeout=0 --env=prod -n 
cd .. 
chmod  777 -R pepsneir
