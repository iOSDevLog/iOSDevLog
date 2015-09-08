# How to use
---

## start web service
---

{% highlight bash %}
$ sudo gem install sinatra pathname cocoapods cocoapods-core colored
$ vim app.rb
{% endhighlight %}

charge **path** to you  "CocoaPods Specs repository".

`Dir.glob('/Users/jiaxianhua/.cocoapods/repos/master/Specs/**/**/*.json') do |spec_path|`

{% highlight bash %}
$ ruby app.rb
{% endhighlight %}

## open url
---

<http://localhost:4567/specs?page=0>
