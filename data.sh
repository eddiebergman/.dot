# TODO: Look into maps in bash
movie_lens_download="files.grouplens.org/datasets/movielens/ml-25m.zip"

dataset () {
    local link="",
    case "$1" in
        "movielens") link="$movie_lens_download";;
        *)
           echo "Whoops, $1 not recognized"
           echo "$dataset_help"
           return
    esac

    local prompt_string="Are you sure you want to download $1 from $link?"
    read -p $prompt_string -n 1 -r
    if [[ $REPLY =~ ^[Yy]$ ]] then
        wget $link
    fi
    return
}
