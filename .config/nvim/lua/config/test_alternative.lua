vim.cmd([[
  function! OpenTestAlternate()
    let test_path = eval('rails#buffer().alternate()')
  
    execute "e " . test_path
  
    if !filereadable(test_path) && join(getline(1,'$'), "\n") == ''
      if test_path =~ "spec/"
        execute "norm itemplate_test\<Tab>"
      else
        execute "norm iminitest\<Tab>"
      endif
    endif
  endfunction

  command! AC call OpenTestAlternate()
]])
