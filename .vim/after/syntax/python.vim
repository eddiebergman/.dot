syn region pythonbdoc start="\"\"\"" end="\"\"\"" fold
highlight link pythonbdoc Type

syntax keyword pythonExtraHighlight containedin=pythonComment pylint Note NOTE type
syntax keyword pythonTyping Type Dict Any Callable Iterator Mapping Literal Union List str bool int float list Iterable Optional object dict TypedDict Sequence Tuple Set TypeVar
syntax match pythonTyping 'np.ndarray'
syntax match pythonTyping 'ndarray'

syntax keyword pythonBuiltinFunc cast
