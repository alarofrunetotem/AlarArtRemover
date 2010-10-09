local __FILE__=tostring(debugstack(1,2,0):match("(.*):1:")) -- MUST BE LINE 1
local me, ns = ...
print("Loading",__FILE__," inside ",me)
local l=LibStub("AceLocale-3.0")
local L=l:NewLocale(me,"enUS",true,true)
--@localization(locale="enUS", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
L=l:NewLocale(me,"frFR",true,true)
if (L) then
--@localization(locale="frFR", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
L=l:NewLocale(me,"deDE",true,true)
if (L) then
--@localization(locale="deDE", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
L=l:NewLocale(me,"koKR",true,true)
if (L) then
--@localization(locale="koKR", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
L=l:NewLocale(me,"esMX",true,true)
if (L) then
--@localization(locale="esMX", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
L=l:NewLocale(me,"ruRU",true,true)
if (L) then
--@localization(locale="ruRU", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
L=l:NewLocale(me,"zhCN",true,true)
if (L) then
--@localization(locale="zhCN", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
L=l:NewLocale(me,"esES",true,true)
if (L) then
--@localization(locale="esES", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
L=l:NewLocale(me,"zhTW",true,true)
if (L) then
--@localization(locale="zhTW", format="lua_additive_table" , escape-non-ascii=true, same-key-is-true=true, handle-unlocalized="english" )@
end
