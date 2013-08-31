let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
            \ 'name': 'file_fixed',
            \ 'default_kind' : 'file',
            \ 'description' : 'candidates from fixed file list',
            \ }

function! s:unite_source.gather_candidates(args, context)
    let fileList = sort(readfile(g:unite_sources_files))

    return map(fileList, 's:create_file_dict(v:val)')
endfunction

function! s:create_file_dict(file)
  let dict = {
        \ 'word' : a:file, 'abbr' : a:file,
        \ 'action__path' : a:file,
        \ 'vimfiler__is_directory' : 0,
        \ 'action__directory' : fnamemodify(a:file, ':h'),
        \ 'kind' : 'file',
        \}
  return dict
endfunction

call unite#define_source(s:unite_source)

let &cpo = s:save_cpo
unlet s:save_cpo

