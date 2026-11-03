-- Build script for nameref

module = "nameref"

textfiles    = {"*.md", "*.txt"}
installfiles = {"*.sty"}
tdslocations = {
  "doc/latex/nameref/ChangeLog.txt",
  "doc/latex/nameref/README.md",
  "doc/latex/nameref/nameref.pdf",
  "source/latex/hyperref/nameref.dtx",
  "tex/latex/nameref/nameref.sty",
}

specialformats = specialformats or {}
specialformats["latex"] = specialformats["latex"] or
  {
    luatexdev     = {binary="luahbtex",format = "lualatex-dev"},
  }


checkconfigs = {"build"}
checkengines = {"pdftex","luatex"}

checkruns = 2

typesetexe  = "lualatex"

sourcefiles = {
  "*.dtx",
  "*.ins",
}


typesetfiles = {"nameref.dtx"}


packtdszip = false


-- l3build tag auto increases final letter
-- l3build tag AUTO increases .two-digit number and sets final letter to 'a'

tagfiles={"README.md","*.dtx"}
function update_tag(file,content,tagname,tagdate)

local tagpattern="(%d%d%d%d[-/]%d%d[-/]%d%d) v(%d+[.])(%d+)(%l)"
local oldv,newv
if tagname == 'auto' or tagname == 'AUTO' then
  local i,j,olddate,a,b,c
  i,j,olddate,a,b,c= string.find(content, tagpattern)
  if i == nil then
    print('OLD TAG NOT FOUND')
    return content
  else
    print ('FOUND: ' .. olddate .. ' v' .. a .. b .. c)
    oldv = olddate .. ' v' .. a .. b .. c
    if tagname == 'AUTO' then
      newv = tagdate .. ' v'  .. a .. string.format("%02d",math.floor(b + 1)) .. 'a'
    else
      newv = tagdate .. ' v'  .. a .. b .. string.char(string.byte(c)+1)
    end
    print('USING OLD TAG: ' .. oldv)
    print('USING NEW TAG: ' .. newv)
    local oldpattern = string.gsub(oldv,"[-/]", "[-/]")
    content=string.gsub(content,oldpattern,newv)
    return content
  end
else
  error("only automatic tagging supported")
end
end
