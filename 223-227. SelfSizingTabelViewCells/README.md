# 223-227. Self-sizing Table View Cells
---

![SelfSizingCells-1](https://github.com/iOSDevLog/iOSDevLog/raw/master/assets/img/SelfSizingCells-1.png)

![SelfSizingCells-2](https://github.com/iOSDevLog/iOSDevLog/raw/master/assets/img/SelfSizingCells-2.png)

{% highlight ruby %}
# Uncomment this line to define a global platform for your project
platform :ios, '8.0'
# Uncomment this line if you're using Swift
use_frameworks!

target 'selfSizingCells' do

pod 'Alamofire', '~> 3.1.3'
pod 'SwiftyJSON', '~> 2.3.1'
pod 'AlamofireImage', '~> 2.1.1'
pod 'DZNEmptyDataSet', '~> 1.7.2'

end

target 'selfSizingCellsTests' do

end

target 'selfSizingCellsUITests' do

end
{% lighlight %}

