# CoolBlue

This is a search app consists of two screens:
  - Search screen : Searching and listing matching products to the user.
  - Details screen : Displaying detailed product inforamtion.

# Tech
This application is following the MVVM architecture and uses reactive techniques to implement it.

### Used pods

  - Core
      - [Moya](https://github.com/Moya/Moya) : Network handling.
      - [RxSwift](https://github.com/ReactiveX/RxSwift) : Core reactive programming 
      - [RxCocoa](https://github.com/ReactiveX/RxSwift/tree/master/RxCocoa) : UI reactive programming 
  - UI
    - [AlamofireImage](https://github.com/Alamofire/AlamofireImage) : Lazy loading the icons/thumbnails
    - [Cosmos](https://github.com/evgenyneu/Cosmos) : Rating view control

### To do 
  - Following the MVVM approach correctly in the "Detailed" screen regarding handling all the data transformation in the view-model instead of the viewController.
  - Enahncing the UI to be matching the real app/displaying the missing sections (delivered with list - Pros/Cons list).
  - Adding refresh functionality.