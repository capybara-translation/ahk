ConvertKana(str, wideToNarrow)
{
 kanaMap1 := { "ガ": "ｶﾞ", "ギ": "ｷﾞ", "グ": "ｸﾞ", "ゲ": "ｹﾞ", "ゴ": "ｺﾞ", "ザ": "ｻﾞ", "ジ": "ｼﾞ", "ズ": "ｽﾞ", "ゼ": "ｾﾞ", "ゾ": "ｿﾞ", "ダ": "ﾀﾞ", "ヂ": "ﾁﾞ", "ヅ": "ﾂﾞ", "デ": "ﾃﾞ", "ド": "ﾄﾞ", "バ": "ﾊﾞ", "ビ": "ﾋﾞ", "ブ": "ﾌﾞ", "ベ": "ﾍﾞ", "ボ": "ﾎﾞ", "ヴ": "ｳﾞ", "ヷ": "ﾜﾞ", "ヺ": "ｦﾞ", "ヾ": "ヽﾞ", "パ": "ﾊﾟ", "ピ": "ﾋﾟ", "プ": "ﾌﾟ", "ペ": "ﾍﾟ", "ポ": "ﾎﾟ" }
 for k, v in kanaMap1
 {
  If wideToNarrow
  {
   StringReplace, str, str, %k%, %v%, All
  }
  Else
  {
   StringReplace, str, str, %v%, %k%, All
  }
 }

 kanaMap2 := { "。": "｡", "「": "｢", "」": "｣", "、": "､", "・": "･", "゠": "=", "ァ": "ｧ", "ア": "ｱ", "ィ": "ｨ", "イ": "ｲ", "ゥ": "ｩ", "ウ": "ｳ", "ェ": "ｪ", "エ": "ｴ", "ォ": "ｫ", "オ": "ｵ", "カ": "ｶ", "キ": "ｷ", "ク": "ｸ", "ケ": "ｹ", "コ": "ｺ", "サ": "ｻ", "シ": "ｼ", "ス": "ｽ", "セ": "ｾ", "ソ": "ｿ", "タ": "ﾀ", "チ": "ﾁ", "ッ": "ｯ", "ツ": "ﾂ", "テ": "ﾃ", "ト": "ﾄ", "ナ": "ﾅ", "ニ": "ﾆ", "ヌ": "ﾇ", "ネ": "ﾈ", "ノ": "ﾉ", "ハ": "ﾊ", "ヒ": "ﾋ", "フ": "ﾌ", "ヘ": "ﾍ", "ホ": "ﾎ", "マ": "ﾏ", "ミ": "ﾐ", "ム": "ﾑ", "メ": "ﾒ", "モ": "ﾓ", "ャ": "ｬ", "ヤ": "ﾔ", "ュ": "ｭ", "ユ": "ﾕ", "ョ": "ｮ", "ヨ": "ﾖ", "ラ": "ﾗ", "リ": "ﾘ", "ル": "ﾙ", "レ": "ﾚ", "ロ": "ﾛ", "ヮ": "ヮ", "ワ": "ﾜ", "ヰ": "ヰ", "ヱ": "ヱ", "ヲ": "ｦ", "ン": "ﾝ", "ヵ": "ヵ", "ヶ": "ヶ", "ヸ": "ヸ", "ヹ": "ヹ", "・": "･", "ー": "ｰ", "ヽ": "ヽ", "ヿ": "ヿ" }
 for k, v in kanaMap2
 {
  If wideToNarrow
  {
   StringReplace, str, str, %k%, %v%, All
  }
  Else
  {
   StringReplace, str, str, %v%, %k%, All
  }
 }

 Return str
}

WideToNarrow(str)
{
 buf =
 Loop, Parse, str
 {
  If RegExMatch(A_LoopField, "[！-～]") > 0
  {
   code := Asc(A_LoopField) - 65248
   buf := buf . Chr(code)
  }
  Else
  {
   buf := buf . A_LoopField
  }
 }
 StringReplace, buf, buf, 　, %A_Space%, All
 buf := ConvertKana(buf, true)

 Return buf
}

NarrowToWide(str)
{
 buf =
 Loop, Parse, str
 {
  If RegExMatch(A_LoopField, "[!-~]") > 0
  {
   code := Asc(A_LoopField) + 65248
   buf := buf . Chr(code)
  }
  Else
  {
   buf := buf . A_LoopField
  }
 }
 StringReplace, buf, buf, %A_Space%, 　, All
 buf := ConvertKana(buf, false)

 Return buf
}
;--- Convert wide alphanumeric and katakana characters to narrow characters. ---;
vk1Dsc07B & n::
   ClipSaved := ClipboardAll
   Clipboard =
   Send, ^c
   ClipWait, 2, 1
   Clipboard := WideToNarrow(Clipboard)
   Send, ^v
   Sleep 100
   Clipboard := ClipSaved
   ClipSaved =
   Return

;--- Convert narrow alphanumeric and katakana characters to wide characters. ---;
vk1Dsc07B & w::
   ClipSaved := ClipboardAll
   Clipboard =
   Send, ^c
   ClipWait, 2, 1
   Clipboard := NarrowToWide(Clipboard)
   Send, ^v
   Sleep 100
   Clipboard := ClipSaved
   ClipSaved =
   Return

