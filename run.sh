config="$(locate config.js | grep ckeditor | head -1)"
en="$(locate en.js | grep ckeditor | head -1)"
editor="$(locate editor.css | grep ckeditor | head -1)"
styles=`locate styles.js | grep ckeditor | head -1`
contents=`locate contents.css | grep ckeditor | head -1`
icons=`locate icons.png | grep ckeditor | head -1`

echo $config

mkdir public/assets/ckeditor
mkdir public/assets/ckeditor/skins
mkdir public/assets/ckeditor/skins/moono
mkdir public/assets/ckeditor/lang
cp $editor public/assets/ckeditor/skins/moono
cp $contents public/assets/ckeditor/
cp $icons public/assets/ckeditor/skins/moono
cp $config public/assets/ckeditor/config.js
cp $styles public/assets/ckeditor/styles.js
cp $en public/assets/ckeditor/lang/en.js

