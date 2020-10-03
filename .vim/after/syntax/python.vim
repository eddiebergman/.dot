syn region pythonbdoc start="\"\"\"" end="\"\"\"" fold
highlight link pythonbdoc Type

syntax keyword pythonExtraHighlight containedin=pythonComment pylint Note NOTE type
syntax keyword pythonTyping Type Dict Any Callable Iterator Mapping Literal Union
highlight link pythonTyping Type
highlight link pythonExtraHighlight Todo

