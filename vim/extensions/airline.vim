if exists('g:loaded_airline') && g:loaded_airline
  " airline statusline configuration
  "
  " Sections
  "
  " variable names                default contents
  " ----------------------------------------------------------------------------
  " let g:airline_section_a       (mode, crypt, paste, spell, iminsert)
  " let g:airline_section_b       (hunks, branch)
  " let g:airline_section_c       (bufferline or filename)
  " let g:airline_section_gutter  (readonly, csv)
  " let g:airline_section_x       (tagbar, filetype, virtualenv)
  " let g:airline_section_y       (fileencoding, fileformat)
  " let g:airline_section_z       (percentage, line number, column number)
  " let g:airline_section_error   (ycm_error_count, syntastic, eclim)
  " let g:airline_section_warning (ycm_warning_count, whitespace)

  " here is an example of how you could replace the branch indicator with
  " the current working directory, followed by the filename.
  " let g:airline_section_b = '%{getcwd()}'
  " let g:airline_section_c = '%t'
  "
  let g:airline_powerline_fonts = 1
  let g:airline_section_a = airline#section#create(['branch'])
  let g:airline_section_b = airline#section#create([''])
  let g:airline_section_c = airline#section#create(['%t', 'tagbar'])
  let g:airline_section_z = airline#section#create(['windowswap', '%3p%% ', 'linenr', ':%3v'])
endif
