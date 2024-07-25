while getopts d: flag
do
    case "${flag}" in
        d) directory=${OPTARG};;
    esac
done

cd ../superapp
npx expo export --platform ios
cd ../updater
rm -rf updates/$directory/
#mkdir -p updates/$directory/
cp -r ../superapp/dist/ updates/$directory
