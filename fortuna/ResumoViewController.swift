//
//  ResumoViewController.swift
//  fortuna
//
//  Created by Rafael Parente on 28/04/19.
//  Copyright © 2019 João Paulo de Araújo Ferreira. All rights reserved.
//

import UIKit

protocol ResumoViewControllerDelegate: class {
    
    func saveLancamento(descricao: String?, categoria: String, valor: Float, moeda: String)
    
}

class ResumoViewController: UIViewController {

    @IBOutlet weak var lancamentosTableView: UITableView!
    
    var lancamentos: [Lancamento]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lancamentosTableView.dataSource = self
    }
    
}

extension ResumoViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lancamentos?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "lancamentoCell", for: indexPath)
        
        if let lancamentos = lancamentos {
            let lancamento = lancamentos[indexPath.row]
            cell.textLabel?.text = lancamento.descricao ?? lancamento.categoria
            cell.detailTextLabel?.text = "\(lancamento.moeda) \(lancamento.valor)"
            cell.detailTextLabel?.textColor = lancamento.isGasto ? .red : .green
            cell.accessoryType = .disclosureIndicator
        }
        
        return cell
    }
    
}

extension ResumoViewController: FortunaToolbarProtocol {
    
    func didTapMaisBarButtonItem() {
        performSegue(withIdentifier: "novoLancamento", sender: nil)
    }
    
    func didTapMenosBarButtonItem() {
        
    }
    
}

extension ResumoViewController: ResumoViewControllerDelegate {
    
    func saveLancamento(descricao: String?, categoria: String, valor: Float, moeda: String) {
        //let lancamento = 
    }
    
}
