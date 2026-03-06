//
//  MainTests.swift
//  login-uikit-ui-testingTests
//
//  Created by Jessica Vasquez on 27/01/2026.
//

import XCTest
@testable import login_uikit_ui_testing

final class MainTests: XCTestCase { // ** check later name
    override func setUp() {}
    override func tearDown() {}
    
    // esto esta claro que checkea las acciones del usuario que tienen una caso de uso
    //    for me the use cases can be an error, successful and empty
    //    func viewDidLoad() // initial state for me the use cases can be an error, successful and empty //  get items should be testing
    //    func didPullRefresh() // updating state for me the use cases can be an error, successful and empty
    //    however there is previous data
    //    func didTapCell() // validate the selected item
    //    naming: funcName, when (input) and then (out)
    
    // or init // check later
    
    // func testViewDidLoad_whenInitialAndItemsAreEmptied_thenThrowAnError() { // no es una throwing funcion por el error se maneja en la capa de servicio esta solo da una respuesta de acuerdo al error
    
    // se testea un poco lo que es el repository osea esa separacion entre vm y logica de llamado del servicio
    
    func testLaodItems_whenSetInitialStateWithEmptiedItems_ThenPerfomanceSuccessfulllyAndRetrievedItems() {
        // Given
        let expectedItems: Items = [Item(title: "title 1", image: UIImage()),
                                    Item(title: "title 2", image: UIImage())]
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        serviceMock.result = .success(expectedItems)
        
        // Sut
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
        
        // When
        sut.viewDidLoad()
        
        XCTAssertTrue(viewMock.isLoading) // this call may attention
        // XCTAssertFalse(viewMock.isLoading) // this call may attention
        XCTAssertEqual(viewMock.viewModel.count, 2)
        XCTAssertEqual(viewMock.viewModel.first?.title, expectedItems.first?.title)
        
        XCTAssertNil(viewMock.selectedItem)
        XCTAssertTrue(viewMock.message.isEmpty)
        XCTAssertTrue(viewMock.isEmptyState)
    }
    
    //    func test_loadMovies_success_showsMovies() {
    //        let view = MoviesViewMock()
    //        let service = MoviesServiceMock()
    //
    //        service.result = .success([
    //            Movie(title: "Batman", imageURL: URL(string: "https://image.com")!)
    //        ])
    //
    //        let presenter = MoviesPresenter(view: view, service: service)
    //
    //        presenter.loadMovies()
    //
    //        XCTAssertTrue(view.showedLoading)
    //        XCTAssertEqual(view.showedMovies?.count, 1)
    //        XCTAssertEqual(view.showedMovies?.first?.title, "Batman")
    //    }
    
    func testLoadItems_whenSetInitialStateWithEmptiedItems_ThenPerfomanceSuccessllyAndRetrievedEmptiedItems() { // check later
        // Given
        let expectedItems: Items = []
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        
        serviceMock.result = .success(expectedItems)
        
        // sut
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewMock.viewModel.isEmpty)
        XCTAssertFalse(viewMock.isLoading)
        XCTAssertNil(viewMock.selectedItem)
        XCTAssertTrue(viewMock.message.isEmpty)
        XCTAssertTrue(viewMock.isEmptyState)
    }
    
    func testLoadItems_whenSetInitialStateWithEmptiedItems_ThenPerfomanceWithError() { // check later
        // Given
        let expectedItems: Items? = nil
        let expectedError = NetworkError.invalidURL // donde checkeas las output si son void no value return, creo que tendrias que checkear tal vez el status y las variables modificadas despues de esta consulta, estas en el parametro no en la en la capa de networking
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        
        serviceMock.result = .failure(expectedError)
        
        // sut
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(viewMock.viewModel.isEmpty)
        XCTAssertEqual(viewMock.message, "Ops something it's wrong") // "" improve
        XCTAssertNil(viewMock.selectedItem)
        XCTAssertFalse(viewMock.isLoading)
        XCTAssertFalse(viewMock.isEmptyState)
    }
    
    // we need here another definition - since we need to know if this function is exclusive for load items, or reload action is associated too
    
    func testPullResfresh_whenSetUpdatingStateWithValidItems_ThenPerfomanceSuccefullyAndLoadMoreItems() {
        // Given
        let firstItemsInput: Items = [Item(title: "item 1", image: UIImage()),
                                     Item(title: "item 2", image: UIImage())]
        let secondItemsInput: Items = [Item(title: "item 3", image: UIImage()),
                                     Item(title: "item 4", image: UIImage())]
        
        let expectedOuput: Items = firstItemsInput + secondItemsInput
        
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        serviceMock.result = .success(firstItemsInput)
        
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
        sut.viewDidLoad()
        serviceMock.result = .success(secondItemsInput)
                
        // When
        sut.didPullRefresh()
        
        // Then
        XCTAssertNil(viewMock.selectedItem)
        XCTAssertFalse(viewMock.isLoading)
        XCTAssertTrue(viewMock.message.isEmpty)
        XCTAssertFalse(viewMock.isEmptyState)
        
        XCTAssertTrue(viewMock.viewModel.count == expectedOuput.count)
        XCTAssertEqual(viewMock.viewModel.first?.title, expectedOuput.first?.title)
        XCTAssertEqual(viewMock.viewModel.last?.title, expectedOuput.last?.title)
        
    }
    
    func testPullResfresh_whenSetUpdatingStateWithValidItems_ThenPerfomanceSuccessllyAndRetrievedEmptiedItems() {
        
        // Given
        let items: Items = [Item(title: "item 1", image: UIImage()),
                            Item(title: "item 2", image: UIImage())]
        let secondItems: Items = []
        let expectedOutput = items + secondItems
        
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        serviceMock.result = .success(items)
        
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
        sut.viewDidLoad()
        
        serviceMock.result = .success(secondItems)
       
        // When
        sut.didPullRefresh()
        
        // Then
        XCTAssertFalse(viewMock.isEmptyState)
        XCTAssertFalse(viewMock.isLoading)
        XCTAssertTrue(viewMock.message.isEmpty)
        XCTAssertNil(viewMock.selectedItem)
        
        XCTAssertTrue(viewMock.viewModel.count == expectedOutput.count)
        XCTAssertEqual(viewMock.viewModel.first?.title, expectedOutput.first?.title)
    }
    
    func testPullResfresh_whenSetUpdatingStateWithValidItems_ThenPerfomanceWithError() {
        // Given
        let expectedItemsOutput = [Item(title: "title 1", image: UIImage())]
        
        let expectedError: NetworkError = .decodeError
        
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        serviceMock.result = .success(expectedItemsOutput)
        
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
      
        sut.viewDidLoad()
        
        serviceMock.result = .failure(expectedError)
        
        // When
        sut.didPullRefresh()
        
        // Then
        XCTAssertTrue(viewMock.message.isEmpty)
        XCTAssertEqual(viewMock.viewModel.count, expectedItemsOutput.count)
        XCTAssertEqual(viewMock.viewModel.first?.title, expectedItemsOutput.first?.title)
        
        XCTAssertFalse(viewMock.isLoading)
        XCTAssertFalse(viewMock.isEmptyState)
        XCTAssertNil(viewMock.selectedItem)
    }
   
    func testDidTapCell_whenValidItems_thenSuccessAndResetSelectedItem() {
        // Given
        let items = [Item(title: "title", image: UIImage())]
        let indexPathInput: IndexPath = IndexPath(row: 0, section: 1) //not sure
        
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        
        serviceMock.result = .success(items)
       
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
        
        sut.viewDidLoad()
        
        // When
        sut.didTapCell(with: indexPathInput)
        
        // Then
        XCTAssertNotNil(viewMock.selectedItem)
      
        XCTAssertEqual(viewMock.viewModel.count, items.count)
        XCTAssertEqual(viewMock.viewModel.first?.title, items.first?.title)
        
        XCTAssertEqual(viewMock.selectedItem?.title, items.first?.title)
        
        XCTAssertFalse(viewMock.isEmptyState)
        XCTAssertFalse(viewMock.isLoading)
        XCTAssertTrue(viewMock.message.isEmpty)
        // valida el resto + nil after it all completed - its is private
    }
    
    func testDidTapCell_whenEmptiedItems_thenRowDoesNotExistError() {
        // Given
        let items: Items = []
        let indexPathInput = IndexPath(row: 2, section: 1)
        
        let viewMock = MainViewMock()
        let serviceMock = MainServiceMock()
        
        serviceMock.result = .success(items)
        
        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
        sut.viewDidLoad()
        
        // When
        sut.didTapCell(with: indexPathInput)
        
        // Then
        XCTAssertFalse(viewMock.isEmptyState)
        XCTAssertFalse(viewMock.isLoading)
        XCTAssertTrue(viewMock.isEmptyState)
        XCTAssertTrue(viewMock.viewModel.isEmpty)
        XCTAssertNil(viewMock.selectedItem)
    }
    
//    func testDidTapCell_whenValidItems_thenRowDoesNotExistError() {
//        // Given
//        let items = [Item(title: "title 1", image: UIImage())]
//        let indexPathInput = IndexPath(row: 2, section: 1)
//        
//        let viewMock = MainViewMock()
//        let serviceMock = MainServiceMock()
//        
//        serviceMock.result = .success(items)
//        
//        let sut = MainViewPresenter(view: viewMock, service: serviceMock)
//        sut.viewDidLoad()
//        
//        // When
//        sut.didTapCell(with: indexPathInput)
//        
//        // Then
//        
//    }

 
    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

/*
 
 //    func testLoadItems_whenSetInitialStateWithEmptyItems_ThenPerfomanceSuccessfulllyAndRetrievedItems() {
 //        // Given
 //
 //        // input // parameters might be needed for the endpoint
 //        let expectedItems: Items = [Item(title: "", image: UIImage()),
 //                                    Item(title: "", image: UIImage())]
 //        let shouldHandleError = false
 //
 //        let mockService = MockService(shouldHandleError: shouldHandleError, items: expectedItems)
 //
 //        // output // networkError
 //
 //        // sut
 //    //    let sut = MainViewPresenter(service: mockService) // init
 //        // sabes que tiene que llamar initial state, viewdidload, get items
 //
 //        // When
 //        // sut.viewDidLoad()
 //
 //        // Then
 //        let output = sut.model
 //        XCTAssertTrue(output != nil)
 //        XCTAssertFalse(output!.isEmpty)
 //        XCTAssertTrue(output!.count == 2)
 //
 //        //  might add compare identities
 //    }
 
 
 
 func testLoadItems_whenSetInitialStateWithEmptiedItems_ThenPerfomanceSuccessllyAndRetrievedEmptiedItems() { // check later
 // Given
 let expectedItems: Items = []
 let shouldHandleError = false
 let mockService = MockService(shouldHandleError: shouldHandleError, items: expectedItems)
 
 // sut
 let sut = MainViewPresenter(service: mockService)
 
 // When
 
 // Then
 let output = sut.model
 XCTAssertTrue(output == nil)
 XCTAssertFalse(output!.isEmpty)
}

func testFetchItems_whenSetInitialStateWithInvalidItems_ThenPerfomanceWithError() { // check later
 // change state to error
 // Given
 let expectedItems: Items? = nil
 let shouldHandleError = true
 let expectedError = NetworkError.invalidURL // donde checkeas las output si son void no value return, creo que tendrias que checkear tal vez el status y las variables modificadas despues de esta consulta, estas en el parametro no en la en la capa de networking
 let mockService = MockService(shouldHandleError: shouldHandleError, error: NetworkError.invalidURL ,items: expectedItems)
 
 // sut
 let sut = MainViewPresenter(service: mockService)
 
 // When
 
 // Then
 let output = sut.model
 XCTAssertTrue(output == nil)
 XCTAssertFalse(output!.isEmpty)
}

func testPullResfresh_whenSetUpdatingStateWithValidItems_ThenPerfomanceSuccefullyAndAddedNewItems() {
 // Given
 let firstItemsInput: Items = [Item(title: "item 1", image: UIImage()),
                              Item(title: "item 2", image: UIImage())]
 let secondItemsInput: Items = [Item(title: "item 3", image: UIImage()),
                              Item(title: "item 4", image: UIImage())]
 
 let expectedOuput: Items = firstItemsInput + secondItemsInput
 
 let shouldHandleError = false
 let mockService = MockService(shouldHandleError: shouldHandleError, items: firstItemsInput)
 // check later agregar un segunda pedida ?
 let sut = MainViewPresenter(service: mockService)
 
 // When
 sut.didPullRefresh()
 
 // Then
 let output = sut.model
 XCTAssertTrue(output != nil)
 XCTAssertFalse(output!.isEmpty)
 XCTAssertTrue(output!.count == expectedOuput.count)
 XCTAssertTrue(output?[0].title == expectedOuput[0].title)
}

func testPullResfresh_whenSetUpdatingStateWithValidItems_ThenPerfomanceSuccessllyAndRetrievedEmptiedItems() {
 
 // Given
 let items: Items = [Item(title: "Item 1 ", image: UIImage()),
                     Item(title: "Item 2", image: UIImage())]
 
 let secondItems: Items = []
 
 let expectedOutput = items
 
 let shouldHandleError = false
 let mockService = MockService(shouldHandleError: shouldHandleError, items: items, secondItems: secondItems)
 let sut = MainViewPresenter(service: mockService)
 
 // When
 sut.didPullRefresh()
 
 // Then
 let output = sut.model
 XCTAssertTrue(output != nil)
 XCTAssertFalse(((output?.isEmpty) != nil))
 XCTAssert(output?.count == expectedOutput.count)
 XCTAssertEqual(output?[0].title, expectedOutput[0].title)
}

func testPullResfresh_whenSetUpdatingStateWithValidItems_ThenPerfomanceWithError() {
}

func testDidTapCell_when_thenSuccess() {
 
}

func testDidTapCell_when_thenError() {
 
}

func testDidTapCell_when_thenNil() {
 
}

func testPerformanceExample() throws {
 // This is an example of a performance test case.
 self.measure {
     // Put the code you want to measure the time of here.
 }
}
*/


//struct MockService: EndpointProtocol { // tiene otro procotol no este
//    let shouldHandleError: Bool
//    let error: NetworkError?
//    let items: Items? // deberia ser nil ??
//    let secondItems: Items?
//
//    init(shouldHandleError: Bool, error: NetworkError? = nil, items: Items? = nil, secondItems: Items? = nil) {
//        self.shouldHandleError = shouldHandleError
//        self.error = error
//        self.items = items
//        self.secondItems = secondItems
//    }
//
//    func fecth<T>(request: URLRequest, completionHandler: @escaping (Result<T, login_uikit_ui_testing.NetworkError>) -> ()) where T : Decodable {
//
//        guard !shouldHandleError else {
//            completionHandler(.failure(error!))
//            return
//        }
//
//        // check later - might need a second funcion calling by update view
//        guard let secondItems = secondItems, let items = items else {
//            completionHandler(.success(items as! T)) /// check later
//            return
//        }
//
//        let updatedItems = items + secondItems
//        completionHandler(.success(updatedItems as! T)) // check later
//    }
//}
