let s:save_cpo = &cpo
set cpo&vim

let s:unite_kind = {
            \ 'name': 'annotate',
            \ 'default_action': 'log',
            \ 'action_table': {},
            \ 'parents': 'common',
            \ }
let s:unite_kind.action_table.log = {
            \ 'is_selectable': 1,
            \ 'description': 'Show changeset information',
            \ }
function! s:unite_kind.action_table.log.func(candidates)
    if len(a:candidates) == 0
        echo "candidates must be only one"
        return
    endif
    call s:show_log(a:candidates[0].log)
endfunction

let s:unite_kind.action_table.patch = {
            \ 'is_selectable': 1,
            \ 'description': 'Show changeset patch',
            \ }
function! s:unite_kind.action_table.patch.func(candidates)
    if len(a:candidates) == 0
        echo "candidates must be only one"
        return
    endif
    call s:show_patch(a:candidates[0].log)
endfunction

function! s:show_log(version)
    call RunShellCommand(g:unite_sources_ssh . ' "cd trunk;hg log -r ' . a:version . '"')
endfunction

function! s:show_patch(version)
    call RunShellCommand(g:unite_sources_ssh . ' "cd trunk;hg log -r ' . a:version . ' -p"')
endfunction

call unite#define_kind(s:unite_kind)

let &cpo = s:save_cpo
unlet s:save_cpo
