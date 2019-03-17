import UIKit

class PagesDataSource: NSObject, UIPageViewControllerDataSource {

    var pages = [UIViewController]()

    init(pages: [UIViewController]) {
        self.pages = pages
    }

    private func page(relativeTo viewController: UIViewController, increment: Int) -> UIViewController? {
        let currentIdx = pages.index(of: viewController)!
        let newIdx = currentIdx + increment
        return self.pages.indices.contains(newIdx) ? self.pages[newIdx] : .none
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.page(relativeTo: viewController, increment: -1)
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.page(relativeTo: viewController, increment: 1)
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return self.pages.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return 0
    }

}

class ExamplePageViewController: UIPageViewController {

    var pagesDataSource: PagesDataSource!

    override func viewDidLoad() {
        super.viewDidLoad()

        let storyboard = self.storyboard!
        let pageControllerIds = ["page1", "page2"]
        self.pagesDataSource = PagesDataSource(pages: pageControllerIds.map(storyboard.instantiateViewController))
        self.dataSource = self.pagesDataSource

        setViewControllers([pagesDataSource.pages[0]], direction: .forward, animated: false, completion: nil)
    }

}
