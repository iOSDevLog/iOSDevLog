## 135. 14. Making Your Mac App’s Data Scriptable
---

### AppleScript Editor

启动 **Noteland**。

启动 **/Applications/Utilities/Script Editor.app/**。

运行下面的脚本：

{% highlight applescript %}
tell application "Noteland"
    every note
end tell
{% endhighlight %}

在底部的结果窗口中，你会看到下面这样的信息：

{note id "0B0A6DAD-A4C8-42A0-9CB9-FC95F9CB2D53" of application "Noteland", note id "F138AE98-14B0-4469-8A8E-D328B23C67A9" of application "Noteland"}
当然，ID 会有所不同，但是这些迹象表明，它在工作。

试一试这个脚本：

    tell application "Noteland"
        name of every note
    end tell

你会在结果窗中看到 {"Note 0", "Note 1"}。

再试一下这个脚本：

    tell application "Noteland"
        name of every tag of note 2
    end tell

结果：{"Tiger Swallowtails", "Steak-frites"}。

（请注意 AppleScript 数组是基于 1 的，所以 2 指的是第二个笔记。当我们明白这个以后，就一点也不奇怪了）

你也可以创建笔记：

    tell application "Noteland"
        set newNote to make new note with properties {body:"New Note" & linefeed & "Some text.", archived:true}
        properties of newNote
    end tell

结果将会是类似这样的（详细信息有相应改变）：

{creationDate:date "2015年10月12日 星期一 下午9:55:44", archived:true, name:"New Note", class:note, id:"630E5DCB-7CA2-40B2-8A36-E2025C4EC45B", body:"New Note
Some text."}

你还可以创建新的标签：

    tell application "Noteland"
        set newNote to make new note with properties {body:"New Note" & linefeed & "Some text.", archived:true}
        set newTag to make new tag with properties {name:"New Tag"} at end of tags of newNote
        name of every tag of newNote
    end tell

结果会是：{"New Tag"}。

完美工作！

![135. 14-AppleScript Editor](https://github.com/iOSDevLog/iOSDevLog/raw/master/assets/img/135. 14-AppleScript Editor.png)
