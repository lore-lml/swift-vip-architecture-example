//
//  StaffSceneViewController.swift
//  vip_architecture_example
//
//  Created by Lorenzo Limoli on 29/06/22.
//  Copyright (c) 2022 Lorenzo Limoli. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates
//  https://github.com/lore-lml

import UIKit

// MARK: Controller Delegate
protocol IStaffSceneDelegate: AnyObject{
    func didReceiveFetchStaffViewModel(_ vms: [StaffSceneModels.FetchStaff.ViewModel])
    func didReceiveFetchStaffImageViewModel(_ vm: StaffSceneModels.FetchStaffImage.ViewModel)
    func didReceiveError(_ errorVm: StudentsSceneModels.ShowError.ViewModel)
    func showCharacterDetail(_ detail: StaffSceneModels.ShowCharacterDetail.ViewModel)
}

class StaffSceneViewController: UIViewController {
    
    var router: IStaffSceneRouter!
    var interactor: IStaffSceneInteractor!
    
    // MARK: OUTLETS
    @IBOutlet weak var tableView: UITableView!
    
    private var _loadingView: LoadingView?
    private var _staff: [StaffSceneModels.FetchStaff.ViewModel] = []
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NavBarCustomizer.defaultStyle(for: self)

        _loadingView = .loadView(into: self.view, autoPlay: false)
        _configureTableView()
        _fetchStaff()
    }
    
    private func _configureTableView(){
        tableView.delegate = self
        tableView.dataSource = self
        CharacterTableViewCell.subscribe(to: tableView)
    }
}

extension StaffSceneViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        _staff.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CharacterTableViewCell.cellId, for: indexPath) as! CharacterTableViewCell
        
        let character = _staff[indexPath.row]
        cell.configure(character: character)
        
        
        _fetchStudentImage(.init(cellIndex: indexPath, dtoCharacter: character.dtoCharacter))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        _showCharacterDetailRequest(
            .init(
                cellIndex: indexPath,
                dtoCharacter: _staff[indexPath.row].dtoCharacter
            )
        )
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension StaffSceneViewController: IStaffSceneDelegate{
    // MARK: DISPLAY LOGIC IMPLEMENTATION INTERFACE
    
    private func _fetchStaff(){
        _loadingView?.play()
        interactor.fetchStaffRequest()
    }
    func didReceiveFetchStaffViewModel(_ vms: [StaffSceneModels.FetchStaff.ViewModel]){
        self._staff = vms
        tableView.reloadData()
        _loadingView?.stop()
    }
    
    
    private func _fetchStudentImage(_ request: StudentsSceneModels.FetchStudentImage.Request){
        interactor.fetchStaffImageRequest(request)
    }
    func didReceiveFetchStaffImageViewModel(_ vm: StaffSceneModels.FetchStaffImage.ViewModel){
        
        guard let img = vm.studentImg else { return }
        
        var studentVm = _staff[vm.cellIndex.row]
        studentVm.isLoading = false
        studentVm.image = img
        
        _staff[vm.cellIndex.row] = studentVm
        
        (tableView.cellForRow(at: vm.cellIndex) as? CharacterTableViewCell)?
            .configure(character: studentVm)
            
    }
    
    
    private func _showCharacterDetailRequest(_ request: StudentsSceneModels.ShowCharacterDetail.Request){
        interactor.showCharacterDetailRequest(request)
    }
    func showCharacterDetail(_ detail: StudentsSceneModels.ShowCharacterDetail.ViewModel){
        self.router.showCharacterDetail(detail)
    }
    
    
    func didReceiveError(_ errorVm: StudentsSceneModels.ShowError.ViewModel){
//        Log.e(errorVm.description)
    }
}
