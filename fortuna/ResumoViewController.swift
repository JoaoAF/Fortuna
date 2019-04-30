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
    @IBOutlet weak var saldoLabel: UILabel!
    
    var lancamentos: [Lancamento]? {
        didSet {
            lancamentosTableView.reloadData()
            atualizarSaldo()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        lancamentosTableView.dataSource = self
        lancamentosTableView.delegate = self
        
        lancamentos = try? CoreDataManager.shared.context.fetch(Lancamento.fetchRequest())
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let novoLancamentoViewController = segue.destination as? NovoLancamentoViewController {
            novoLancamentoViewController.delegate = self
            
            if let sender = sender as? String {
                novoLancamentoViewController.loadAsGasto = sender == "Menos"
            } else if let sender = sender as? Lancamento {
                    novoLancamentoViewController.currentLancamento = sender
            }
        }
    }
    
    func atualizarSaldo() {
        guard let lancamentos = lancamentos else { return }
        
        var total: Float = 0.00
        for l in lancamentos {
            if l.isGasto {
                total = total - l.valor
            } else {
                total = total + l.valor
            }
        }
        
        saldoLabel.text = "R$ \(total)"
        if total > 0 {
            saldoLabel.textColor = .green
        } else if total < 0 {
            saldoLabel.textColor = .red
        } else {
            saldoLabel.textColor = saldoLabel.highlightedTextColor
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

extension ResumoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let lancamento = lancamentos?[indexPath.row] {
            performSegue(withIdentifier: "segueLancamento", sender: lancamento)
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Resumo"
    }
    
}

extension ResumoViewController: FortunaToolbarProtocol {
    
    func didTapMaisBarButtonItem() {
        performSegue(withIdentifier: "segueLancamento", sender: "Mais")
    }
    
    func didTapMenosBarButtonItem() {
        performSegue(withIdentifier: "segueLancamento", sender: "Menos")
    }
    
}

extension ResumoViewController: NovoLancamentoViewControllerDelegate {
    
    func saveLancamento(categoria: String, moeda: String, valor: Float, isGasto: Bool, descricao: String?) {
        let lancamento = Lancamento(context: CoreDataManager.shared.context)
        lancamento.categoria = categoria
        lancamento.moeda = moeda
        lancamento.valor = valor
        lancamento.isGasto = isGasto
        lancamento.descricao = descricao
        
        if let _ = try? CoreDataManager.shared.saveContext() {
            if let indexPath = lancamentosTableView.indexPathForSelectedRow {
                lancamentos?[indexPath.row] = lancamento
                //lancamentosTableView.deselectRow(at: indexPath, animated: false)
            } else {
                lancamentos?.append(lancamento)
            }
        }
    }
    
    func delLancamento(_ lancamento: Lancamento) {
        if let indexPath = lancamentosTableView.indexPathForSelectedRow {
            CoreDataManager.shared.context.delete(lancamento)
            
            if let _ = try? CoreDataManager.shared.saveContext() {
                //lancamentosTableView.deselectRow(at: indexPath, animated: false)
                lancamentos?.remove(at: indexPath.row)
            }
        }
    }
    
}
