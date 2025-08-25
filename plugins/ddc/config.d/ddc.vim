" cf. https://qiita.com/maachan_9692/items/9b507fd043424013abde
"
call ddc#custom#patch_global('ui', 'native')

" ddc-source-lsp supports native-lsp!
" https://github.com/Shougo/ddc-source-lsp/blob/main/doc/ddc-source-lsp.txt
call ddc#custom#patch_global('sources', ['around', 'file', 'lsp'])

" 前の設定だとどっちがaround かfile かわからないのでmark を設定
call ddc#custom#patch_global('sourceOptions', #{
    \ _: #{
    \   matchers: ['matcher_fuzzy'],
    \   sorters: ['sorter_fuzzy'],
    \   converters: ['converter_fuzzy'],
    \   minAutoCompleteLength: 1,
    \ },
    \ around: #{
    \   mark: 'A',
    \   maxItems: 5,
    \ },
    \ file: #{
    \   mark: 'F',
    \   isVolatile: v:true,
    \   forceCompletionPattern: '\S/\S*',
    \   maxItems: 5,
    \ },
    \ lsp: #{
    \   isVolatile: v:true,
    \   mark: 'lsp',
    \   forceCompletionPattern: '\.\w*|:\w*|->\w*',
    \   sorters: ['sorter_lsp-kind'],
    \   maxItems: 10,
    \ },
    \})

call ddc#custom#patch_filetype(
    \ ['ps1', 'dosbatch', 'autohotkey', 'registry'], {
    \ 'sourceOptions': {
    \   'file': {
    \     'forceCompletionPattern': '\S\/\S*',
    \   },
    \ },
    \ 'sourceParams': {
    \   'file': {
    \     'mode': 'unix',
    \   },
    \ }})

" call ddc#custom#patch_global('sourceOptions', #{
"       \   lsp: #{
"       \     isVolatile: v:true,
"       \     mark: 'lsp',
"       \     forceCompletionPattern: '\.\w*|:\w*|->\w*',
"       \     sorters: ['sorter_lsp-kind'],
"       \   },
"       \ })

" Register snippet engine (vim-vsnip)
call ddc#custom#patch_global('sourceParams', #{
      \   lsp: #{
      \     snippetEngine: denops#callback#register({
      \           body -> vsnip#anonymous(body)
      \     }),
      \   }
      \ })

call ddc#enable()

" <TAB>: completion.
inoremap <expr> <TAB>
    \ pumvisible() ? '<C-n>' :
    \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
    \ '<TAB>' : ddc#map#manual_complete()

" <S-TAB>: completion back.
inoremap <expr> <S-TAB>  pumvisible() ? '<C-p>' : '<C-h>'
