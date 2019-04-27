import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lancamentosTablewView: UITableView!
    
    var lancamentos: [Lancamento]?

    override func viewDidLoad() {
        super.viewDidLoad()
        lancamentosTablewView.dataSource = self
    }

}

extension ViewController: UITableViewControllerDataSource {
  
    // Return the number of rows for the table.     
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lancamentos?.count ?? 0
    }

    // Provide a cell object for each row.
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Fetch a cell of the appropriate type.
        let cell = tableView.dequeueReusableCell(withIdentifier: "lancamentoCell", for: indexPath)

        if let lancamentos = lancamentos {
            lancamento = lancamentos[indexPath.row]
            cell.textLabel.text = lancamento.descricao ?? lancamento.categoria
            cell.detailTextLabel.text = "\(lancamento.moeda) \(lancamento.valor)"
            cell.detailTextLabel.textColor = lancamento.isGasto ? .red : .green
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }

}
