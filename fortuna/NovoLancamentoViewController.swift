//
//  NovoLancamentoViewController.swift
//  fortuna
//
//  Created by Rafael Parente de Sousa on 29/04/19.
//  Copyright © 2019 João Paulo de Araújo Ferreira. All rights reserved.
//

import UIKit

protocol NovoLancamentoViewControllerDelegate: class {
    
    func saveLancamento(categoria: String, moeda: String, valor: Float, descricao: String?)
    
}

class NovoLancamentoViewController: UIViewController {

    weak var delegate: NovoLancamentoViewControllerDelegate?
    var isGasto: Bool
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let isGasto = isGasto && isGasto {
            lancamentoSwitch.isOn = false
            lancamentoSwitch.backgroundColor = .red
        }
    }
    
    @IBAction func saveLancamento(_ sender: Any) {
        if categoria.isEmpty || moeda.isEmpty || valor.isEmpty {
            return
        }
                
        if let categoria = categoriaTextField.text, let moeda = moedaTextField.text,
            let valor = valorTextField.text, let descricao = descricaoTextField.text {
            if descricao.isEmpty {
                delegate?.saveLancamento(categoria: categoria, moeda: , valor: valor, descricao: nil)
            } else {
                delegate?.saveLancamento(categoria: categoria, moeda: , valor: valor, descricao: descricao)
            }
        }
        
        self.navigationController?.popViewController(animated: true)
    }

}
