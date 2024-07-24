while getopts d: flag
do
    case "${flag}" in
        d) directory=${OPTARG};;
    esac
done

cd ../superapp
npx expo export --platform android
cd ../updater
rm -rf updates/$directory/
cp -r ../superapp/dist/ updates/$directory
