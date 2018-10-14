#!/bin/bash

# Set the docker container name:
curDir=${PWD##*/}
curDir=${curDir,,}
curServiceName="_web-init1_1"
container=$curDir$curServiceName
# echo "Conatiner Name: $container"

# build and start docker images
docker-compose up -d --build

# copy over headless theme
cp -r Docker-wordpress/headless-wp data/wp-content/themes/

# Pause to finish installation manually (annoying I know)
read -n1 -r -p "Please open the site in your brower at http://localhost:8080/ and finish the installation. Press any key when finished to continue..." key

# run wp-cli on installed wordpress image to install plugins, settings & activate theme
wp="docker exec -it $container wp --allow-root"

$wp theme activate headless-wp
$wp theme delete twentyfifteen
$wp theme delete twentysixteen
$wp theme delete twentyseventeen
$wp plugin delete akismet
$wp plugin delete hello

# Pretty URLs required for wp-json path to work correctly
$wp rewrite structure "/%year%/%monthnum%/%day%/%postname%/"

# Update the Hello World post
$wp post update 1 wp-content/themes/headless-wp/post-content/sample-post.txt \
	--post_title="Sample Post" --post_name=sample-post

# Create Homepage content
$wp post create wp-content/themes/headless-wp/post-content/welcome.txt \
	--post_type=page --post_status=publish --post_name=welcome \
	--post_title="Congratulations!"

# Set up example menu
$wp menu create "Header Menu"
$wp menu item add-post header-menu 1
$wp menu item add-post header-menu 2
$wp menu item add-term header-menu category 1
$wp menu item add-custom header-menu \
	"Check out the Vue Docs" https://vuejs.org/v2/api/
$wp menu location assign header-menu header-menu

# Install plugins
$wp plugin install advanced-custom-fields --activate
$wp plugin install acf-to-rest-api --activate
$wp plugin install custom-post-type-ui --activate
$wp plugin install wp-rest-api-v2-menus --activate
#$wp plugin install wordpress-seo --activate
## For when we want to utilize the GraphQL api -- check for updates
#$wp plugin install https://github.com/wp-graphql/wp-graphql/archive/v0.0.33.zip --activate
## Gutenburg is coming:
# gutenberg-custom-fields
# 

# done
echo ""
echo ""
echo "Great. You can now log into WordPress at: http://localhost:8080/wp-admin/"
