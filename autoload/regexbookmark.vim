
function! s:get_bookmarks()
  let s:plugin_dir = expand('<sfile>:p:h:h')
  let s:default_regex_bookmarks_json = s:plugin_dir . '/example.json'

  let g:regex_bookmarks_json = get(g:, 'regex_bookmarks_json', s:default_regex_bookmarks_json)

  let bookmarks_dictionary = webapi#json#decode(join(readfile(expand(g:regex_bookmarks_json)), "\n"))

  let s:bookmarks = copy(bookmarks_dictionary.bookmarks)

  return map(copy(s:bookmarks), 'printf("%s", v:val.description)')
endfunc

function! s:insert(str)
  let chosen_list = filter(copy(s:bookmarks), 'v:val.description == a:str')[0]
  execute chosen_list.regex
endfunction

function! regexbookmark#init()
  cal fzf#run({
        \ 'source':  s:get_bookmarks(),
        \ 'sink':   function('s:insert'),
        \ 'down': '30%',
        \ })
endfunction
