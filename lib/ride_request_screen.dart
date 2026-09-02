import 'package:flutter/material.dart';

class RideRequestScreen extends StatefulWidget {
  const RideRequestScreen({super.key});

  @override
  State<RideRequestScreen> createState() => _RideRequestScreenState();
}

class _RideRequestScreenState extends State<RideRequestScreen> {
  // Controle de qual opção está selecionada (0 = Moto, 1 = Carro)
  int _selectedOption = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // 1. Fundo simulando o Mapa
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE8EAED),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.route, size: 80, color: Colors.blueGrey[200]),
                    const SizedBox(height: 10),
                    Text(
                      "Trajeto da viagem carregado aqui",
                      style: TextStyle(color: Colors.blueGrey[400], fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
          
          // 2. Botão de Voltar (Topo Esquerdo)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () => Navigator.pop(context),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
                  ),
                  child: const Icon(Icons.arrow_back, size: 24, color: Colors.black87),
                ),
              ),
            ),
          ),

          // 3. Inputs de Endereço (Origem e Destino)
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 70, left: 20, right: 20),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 15, offset: Offset(0, 5))],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.my_location, color: Colors.blue, size: 20),
                        SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Ponte da Amizade (Seu local)',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 30, color: Colors.grey[200]),
                    const Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.red, size: 20),
                        SizedBox(width: 15),
                        Expanded(
                          child: TextField(
                            autofocus: true, // Já abre o teclado aqui
                            decoration: InputDecoration(
                              hintText: 'Faculdade (Ex: UCP, UMAX)',
                              border: InputBorder.none,
                              isDense: true,
                            ),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // 4. Bottom Sheet (Opções de Carona)
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, -5))],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Opções de Carona", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 15),
                  
                  // Opção Moto
                  GestureDetector(
                    onTap: () => setState(() => _selectedOption = 0),
                    child: _buildRideOption(
                      title: "UniMoto",
                      time: "5 min",
                      price: "R\$ 5,00",
                      icon: Icons.two_wheeler,
                      description: "Mais rápido. Capacete incluso.",
                      isSelected: _selectedOption == 0,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Opção Carro
                  GestureDetector(
                    onTap: () => setState(() => _selectedOption = 1),
                    child: _buildRideOption(
                      title: "UniCarro",
                      time: "12 min",
                      price: "R\$ 10,00",
                      icon: Icons.directions_car,
                      description: "Até 4 pessoas. Ideal para a chuva.",
                      isSelected: _selectedOption == 1,
                    ),
                  ),
                  
                  const SizedBox(height: 25),
                  
                  // Botão Confirmar
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Lógica para buscar motorista
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0D47A1), // Azul UniRideX
                        padding: const EdgeInsets.symmetric(vertical: 18),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      ),
                      child: Text(
                        _selectedOption == 0 ? "Confirmar UniMoto" : "Confirmar UniCarro", 
                        style: const TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold)
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRideOption({
    required String title, 
    required String time, 
    required String price, 
    required IconData icon, 
    required String description, 
    required bool isSelected
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFE3F2FD) : Colors.transparent, // Fundo azul claro se selecionado
        border: Border.all(color: isSelected ? const Color(0xFF0D47A1) : Colors.grey[300]!, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        children: [
          Icon(icon, size: 40, color: Colors.black87),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    const SizedBox(width: 10),
                    Icon(Icons.person, size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 2),
                    Text(title == "UniMoto" ? "1" : "4", style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text(time, style: TextStyle(color: Colors.green[700], fontSize: 12, fontWeight: FontWeight.bold)),
                Text(description, style: TextStyle(color: Colors.grey[600], fontSize: 12)),
              ],
            ),
          ),
          Text(price, style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18)),
        ],
      ),
    );
  }
}
