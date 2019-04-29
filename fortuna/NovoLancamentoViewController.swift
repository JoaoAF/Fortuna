//
//  NovoLancamentoViewController.swift
//  fortuna
//
//  Created by Rafael Parente de Sousa on 29/04/19.
//  Copyright © 2019 João Paulo de Araújo Ferreira. All rights reserved.
//

import UIKit

class NovoLancamentoViewController: UIViewController {

    weak var delegate: ResumoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveLancamento(_ sender: Any) {
        delegate?.saveLancamento(descricao: descricao, categoria: categoria, valor: valor, moeda: moeda)
    }

}
