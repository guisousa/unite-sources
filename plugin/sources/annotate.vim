let s:save_cpo = &cpo
set cpo&vim

let s:unite_source = {
            \ 'name': 'annotate',
            \ }

function! s:unite_source.gather_candidates(args, context)
    let fname = expand('%')
    let annotate = s:annotate(fname)
    let lines = map(map(split(annotate, '\n'), 'split(v:val, ":")'), '[v:val[0] . ":" . v:val[1], v:val[0]]')

    return map(lines, '{
                \ "word": v:val[0],
                \ "source": "annotate",
                \ "kind": "annotate",
                \ "log": v:val[1],
                \ }')
endfunction

function! s:annotate(fname)
    return system(g:unite_sources_ssh . ' "cd trunk;hg annotate ' . a:fname . '"')
endfunction

call unite#define_source(s:unite_source)

let &cpo = s:save_cpo
unlet s:save_cpo
