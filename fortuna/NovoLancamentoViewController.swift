//
//  NovoLancamentoViewController.swift
//  fortuna
//
//  Created by Rafael Parente de Sousa on 29/04/19.
//  Copyright © 2019 João Paulo de Araújo Ferreira. All rights reserved.
//

import UIKit

protocol NovoLancamentoViewControllerDelegate: class {
    
    func saveLancamento(categoria: String, moeda: String, valor: Float, isGasto: Bool, descricao: String?)
    func delLancamento(_ lancamento: Lancamento)
    
}

class NovoLancamentoViewController: UIViewController {

    weak var delegate: NovoLancamentoViewControllerDelegate?
    var loadAsGasto: Bool?
    var currentLancamento: Lancamento?
    
    @IBOutlet weak var categoriaTextField: UITextField!
    @IBOutlet weak var moedaTextField: UITextField!
    @IBOutlet weak var valorTextField: UITextField!
    @IBOutlet weak var lancamentoSwitch: UISwitch!
    @IBOutlet weak var descricaoTextField: UITextField!
    @IBOutlet weak var toolbar: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        lancamentoSwitch.layer.cornerRadius = lancamentoSwitch.frame.height / 2
        if let loadAsGasto = loadAsGasto, loadAsGasto {
            lancamentoSwitch.isOn = false
            lancamentoSwitch.backgroundColor = .red
        }
        
        if let lancamento = currentLancamento {
            categoriaTextField.text = lancamento.categoria
            moedaTextField.text = lancamento.moeda
            valorTextField.text = String(lancamento.valor).replacingOccurrences(of: ".", with: ",")
            descricaoTextField.text = lancamento.descricao ?? ""
            lancamentoSwitch.isOn = !lancamento.isGasto
            lancamentoSwitch.backgroundColor = lancamento.isGasto ? .red : .green
            toolbar.isHidden = false
        }
    }
    
    @IBAction func didTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveLancamento(_ sender: Any) {
        if let categoria = categoriaTextField.text, !categoria.isEmpty,
            let moeda = moedaTextField.text, !moeda.isEmpty,
            let valorString = valorTextField.text, !valorString.isEmpty,
            let descricao = descricaoTextField.text,
            let valor = Float(valorString.replacingOccurrences(of: ",", with: ".")) {
            let isGasto = !lancamentoSwitch.isOn
            if descricao.isEmpty {
                delegate?.saveLancamento(categoria: categoria, moeda: moeda, valor: valor, isGasto: isGasto, descricao: nil)
            } else {
                delegate?.saveLancamento(categoria: categoria, moeda: moeda, valor: valor, isGasto: isGasto, descricao: descricao)
            }
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @IBAction func didSwitchLancamentoSwitch(_ sender: UISwitch) {
        sender.backgroundColor = sender.isOn ? .green : .red
    }
    
    @IBAction func didTapTrashItem(_ sender: Any) {
        if let lancamento = currentLancamento {
            delegate?.delLancamento(lancamento)
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}
