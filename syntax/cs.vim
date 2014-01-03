" @see http://www.cnblogs.com/wengjinbao/articles/712427.html
syntax region Block start="^\s*#\s*\(region\)\|{" end="^\s*#\s*\(endregion\)\|}"  transparent fold
syn sync fromstart
set foldmethod=syntax
