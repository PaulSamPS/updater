while getopts d: flag
do
    case "${flag}" in
        d) directory=${OPTARG};;
    esac
done

cd ../eas-test-app
npx expo export
cd ../updater
rm -rf updates/$directory/
cp -r ../eas-test-app/dist/ updates/$directory
