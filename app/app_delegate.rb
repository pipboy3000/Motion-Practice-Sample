class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @viewController = ViewController.alloc.initWithNibName(nil, bundle:nil)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds).tap do |w|
      w.rootViewController = @viewController
      w.makeKeyAndVisible
    end
  end
end
