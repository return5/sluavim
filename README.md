### sluavim  
  A simple Vim like text editor. Input and Output is handled via Ncurses.


#### screenshot
![screenshot](/screenshot/screenShot-sluavim.png?raw=true)  

#### Dependencies
- [make](https://www.gnu.org/software/make/)
- [Lua >= 5.4](https://www.lua.org/download.html) 
- C compiler [(such as GCC)](https://gcc.gnu.org/install/index.html)
- [Ncurses](https://invisible-island.net/ncurses/)

### installing
before running for the first time, navigate to the directory ```/src/luatoncurses/``` and then run the make file ```makeFile``` using the command ```make```

### command line arguments
- ```-h```
  - print help message.   
- ```--help```  
  - print help message.   
- ```-n```  
  - show line numbers(default).   
- ```--line-number```  
  - show line numbers(default).   
- ```-s```  
  - Show cursor.(default)   
- ```--show-cursor```  
  - Show cursor.(default)   
- ```-c```  
  - enable color.   
- ```--enable-color```  
  - enable color.   
- ```-f [filename]```  
  - load file into editor.   
- ```--file [filename]```  
  - load file into editor.   

### keys supported
- ```h``` ```j``` ```k``` ```l```
  - basic movment.
- ```i``` 
  - enter insert mode.
- ```esc``` 
  - enter normal mode.  
- ``dt[c]`` ``df[c]`` ``dT[c]`` ``dF[c]`` ``dd`` ``d$`` ``d^``  
  - delete characters.
- ``yt[c]`` ``yf[c]`` ``yT[c]`` ``yF[c]`` ``yy`` ``y$`` ``y^``
  - copy characters.
- ``p``
  - paste 
- ``q [c]``  
  - record a macro into ``[c]``.
- ``@ [c]``  
  - run a macro which was stored into ``[c]``.
- ``" [c]`` 
  - select register ``[c]``.
- ``[digit][command]`` 
  - run ``[command]``  ``[number]`` of times.
- ``r`` ``R`` 
  - replace characters.
- ``x`` ``X``  
  - remove characters.
- ``:q`` 
  - quit.
- ``:w [filename]`` 
  - write text to ``[filename]``
- ``:wq [filename]`` 
  - write text to ``[filename]`` then quit.
- ``G``
  - jump to bottom of file.
- ``gg``
  - jump to top of file.

### TODO
- add visual select mode
- add search and replace to colon mode
- add undo and redo commands
- loosen coupling to ncurses
- loosen coupling between a few of the classes
- enable colors for basic syntax highlighting
- enable reading syntax highlight files
- add jumping to a specific line based on line number. 
- heavily refactor and clean up seach and replace code. way messier and nasty than i feel okay with. 