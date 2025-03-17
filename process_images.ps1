Get-ChildItem -Path 'public/images/*.jpg' | ForEach-Object {
    magick convert $_.FullName -resize 1920x800^ -gravity center -extent 1920x800 -quality 80 -define jpeg:extent=500KB $_.FullName
}