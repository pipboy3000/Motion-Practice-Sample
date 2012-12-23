class ViewController < UIViewController
  def viewDidLoad
    super

    self.view.backgroundColor = UIColor.blackColor

    # Title label
    @label = UILabel.alloc.initWithFrame(CGRectMake(10,10,300,30)).tap do |l|
      l.backgroundColor = UIColor.clearColor
      l.text = "メリークリスマス"
      l.textColor = UIColor.whiteColor
      l.textAlignment = NSTextAlignmentCenter
      l.font = UIFont.systemFontOfSize(18)
    end

    # Background image
    @imageView = UIImageView.alloc.initWithFrame(CGRectMake(0,
                                                            self.view.frame.size.height - 568,
                                                            320,
                                                            568)).tap do |iv|
      iv.image = UIImage.imageNamed("bg.png")
      iv.contentMode  = UIViewContentModeScaleAspectFit
    end

    self.view.addSubview @imageView
    self.view.addSubview @label

    @animSnowArray ||= []
    [0.5, 0.4, 0.3, 0.2, 0.1].each do |intval|
      NSTimer.scheduledTimerWithTimeInterval(intval, target:self,
                                                     selector:'snowAnim',
                                                     userInfo:nil,
                                                     repeats:true)
    end

    @button = UIButton.buttonWithType(UIButtonTypeCustom).tap do |b|
      b.frame = CGRectMake(10, 10, 32, 32)
      b.setImage(UIImage.imageNamed("btn.png"), forState:UIControlStateNormal)
      b.addTarget(self, action:"showSanta", forControlEvents:UIControlEventTouchUpInside)
    end
    self.view.addSubview(@button)

    santa_size = CGRectMake(160, self.view.frame.size.height - 200, 160, 200) 
    @santa = UIImageView.alloc.initWithFrame(santa_size).tap do |santa|
      santa.animationDuration = 3.0
      santa.animationImages = [UIImage.imageNamed("1.png"), UIImage.imageNamed("2.png")]
    end
    self.view.addSubview(@santa)

    self.snowAnim
  end

  def snowAnim
    @animSnowArray ||= []
    rand = Random.new(123123123123)
    start_x = rand(320)
    size = rand(30)

    @snow = UIImageView.alloc.initWithFrame(CGRectMake(start_x, -40, size, size))
    @snow.image = UIImage.imageNamed("snow.png")
    self.view.addSubview @snow
    context = UIGraphicsGetCurrentContext()
    UIView.beginAnimations(nil, context:context)
    UIView.setAnimationDelegate(self)
    UIView.setAnimationDidStopSelector('stopAnim')
    UIView.setAnimationCurve(UIViewAnimationCurveEaseIn)
    UIView.setAnimationDuration(10.0)
    @animSnowArray << @snow
    @snow.frame = CGRectMake(start_x, self.view.frame.size.height, size, size)
    @snow.transform = CGAffineTransformMakeRotation(Math::PI)
    UIView.commitAnimations
  end

  def stopAnim
    @animSnow = @animSnowArray[0]
    @animSnowArray.delete_at(0)
    @animSnow.removeFromSuperview()
    @animSnow = nil
  end

  def showSanta
    if !@santa.isAnimating
      self.view.bringSubviewToFront(@santa)
      @santa.startAnimating
    else
      @santa.stopAnimating
      self.view.sendSubviewToBack(@santa)
    end
  end
end
