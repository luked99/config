se hlsearch
se ignorecase
se ts=4
se sw=4
se ai
se autowrite
se cindent
se expandtab
se visualbell
se autowrite

filetype on
filetype plugin on
filetype indent on " file type based indentation

augroup Linux
    au BufRead,BufEnter */linux/* set ts=8 sw=8 noexpandtab
    au BufRead,BufEnter */*kernel*/* set ts=8 sw=8 noexpandtab
augroup End

augroup VideoCore
    au BufRead,BufEnter */vc4/* set ts=3 sw=3 expandtab
augroup End
syn on

se makeprg=make\ -w\ -C\ /home/ldiamand/dev/dev/3rdParty/\ BUILD_PLATFORM=bcm\ BUILD_PRODUCT=giga\ bcm-linux-vc
