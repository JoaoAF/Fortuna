//
//  ResumoViewController.swift
//  fortuna
//
//  Created by Rafael Parente on 28/04/19.
//  Copyright © 2019 João Paulo de Araújo Ferreira. All rights reserved.
//

import UIKit

class ResumoViewController: UIViewController {

    @IBOutlet weak var lancamentosTableView: UITableView!
    
    var lancamentos: [Lancamento]? {
        didSet {
            lancamentosTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lancamentosTableView.dataSource = self
        
        lancamentos = try? CoreDataManager.shared.context.fetch(Lancamento.fetchRequest())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let novoLancamentoViewController = segue.destination as? NovoLancamentoViewController,
            let sender = sender as String {
            novoLancamentoViewController.delegate = self
            novoLancamentoViewController.isGasto = sender == "Menos"
        }
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
        performSegue(withIdentifier: "novoLancamento", sender: "Mais")
    }
    
    func didTapMenosBarButtonItem() {
        performSegue(withIdentifier: "novoLancamento", sender: "Menos")
    }
    
}

extension ResumoViewController: NovoLancamentoViewControllerDelegate {
    
    func saveLancamento(categoria: String, moeda: String, valor: Float, descricao: String?) {
        lancamento = Lancamento(context: CoreDataManager.shared.context)
        lancamento.categoria = categoria
        lancamento.moeda = moeda
        lancamento.valor = valor
        lancamento.descricao = descricao
        
        if let _ = try? CoreDataManager.shared.saveContext(),
            let indexPath = lancamentosTableView.indexPathForSelectedRow {
            lancamentos?[indexPath.row] = lancamento
            lancamentosTableView.deselectRow(at: indexPath, animated: false)
        }
    }
    
}
