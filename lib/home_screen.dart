import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Para pegar os dados do usuário logado
import 'ride_request_screen.dart'; 
import 'auth_service.dart'; // Para a função de Logout

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showLocationDialog();
    });
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Row(
            children: [
              Icon(Icons.location_on, color: Colors.black87, size: 30),
              SizedBox(width: 10),
              Text("Permitir Localização", style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          content: const Text(
            "Para uma experiência completa, o UniRideX precisa acessar sua localização.",
            style: TextStyle(fontSize: 16, color: Colors.black54),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Depois", style: TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              ),
              child: const Text("Permitir", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: _buildMenuDrawer(),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              color: const Color(0xFFE8EAED), 
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_rounded, size: 80, color: Colors.blueGrey[300]),
                    const SizedBox(height: 10),
                    Text(
                      "O mapa real do Google será carregado aqui",
                      style: TextStyle(color: Colors.blueGrey[500], fontWeight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                onTap: () => _scaffoldKey.currentState?.openDrawer(),
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 15, offset: const Offset(0, 5))
                    ],
                  ),
                  child: const Icon(Icons.menu, size: 28, color: Colors.black87),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 30, offset: const Offset(0, -10))
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Center(
                    child: Container(
                      width: 50,
                      height: 5,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const RideRequestScreen()));
                      },
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey[300]!, width: 1),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, size: 28, color: Colors.black),
                            const SizedBox(width: 15),
                            const Text(
                              "Para onde vamos?",
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.black87),
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5)],
                              ),
                              child: const Row(
                                children: [
                                  Icon(Icons.access_time_filled, size: 16, color: Colors.black87),
                                  SizedBox(width: 6),
                                  Text("Agora", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                                  Icon(Icons.keyboard_arrow_down, size: 16),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 25),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRichServiceIcon(Icons.directions_car_filled, "Viagem", Colors.black, Colors.grey[200]!, context),
                        _buildRichServiceIcon(Icons.fastfood, "Lanches", Colors.orange[700]!, Colors.orange[50]!, null),
                        _buildRichServiceIcon(Icons.shopping_bag, "Mercado", Colors.green[700]!, Colors.green[50]!, null),
                        _buildRichServiceIcon(Icons.inventory_2, "Envios", Colors.blue[700]!, Colors.blue[50]!, null),
                        _buildRichServiceIcon(Icons.qr_code_scanner, "Pay", Colors.teal[700]!, Colors.teal[50]!, null),
                      ],
                    ),
                  ),

                  const SizedBox(height: 25),
                  
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      "Uniformes & Faculdades",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                    ),
                  ),
                  const SizedBox(height: 15),

                  SizedBox(
                    height: 160,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      children: [
                        _buildPromoBanner(
                          'https://images.unsplash.com/photo-1584432810601-6c7f27d2362b?q=80&w=500', 
                          'UCP',
                          'Jalecos Azuis\nOficiais',
                          'Comprar',
                          Colors.blue,
                        ),
                        _buildPromoBanner(
                          'https://images.unsplash.com/photo-1612349317150-e413f6a5b16d?q=80&w=500', 
                          'UMAX',
                          'Uniformes\nVermelhos',
                          'Ver modelos',
                          Colors.red,
                        ),
                        _buildPromoBanner(
                          'https://images.unsplash.com/photo-1576091160550-2173dba999ef?q=80&w=500', 
                          'MÉDICOS',
                          'Kits para UPAP\ne UNINTER',
                          'Aproveitar',
                          Colors.green,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPromoBanner(String imageUrl, String tag, String title, String buttonText, Color tagColor) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: NetworkImage(imageUrl),
          fit: BoxFit.cover,
        ),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10, offset: Offset(0, 5))],
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: [Colors.black.withOpacity(0.8), Colors.transparent],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(color: tagColor, borderRadius: BorderRadius.circular(5)),
              child: Text(tag, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            Text(
              title, 
              style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900, height: 1.1),
            ),
            const Spacer(),
            Row(
              children: [
                Text(buttonText, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                const SizedBox(width: 5),
                const Icon(Icons.arrow_forward_ios, color: Colors.white, size: 12),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRichServiceIcon(IconData icon, String label, Color iconColor, Color bgColor, BuildContext? contextToNav) {
    return GestureDetector(
      onTap: () {
        if (contextToNav != null) {
           Navigator.push(
            contextToNav,
            MaterialPageRoute(builder: (context) => const RideRequestScreen()),
          );
        }
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(22), 
            ),
            child: Icon(icon, color: iconColor, size: 35),
          ),
          const SizedBox(height: 10),
          Text(
            label, 
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuDrawer() {
    // Pegando os dados do usuário que acabou de logar!
    final user = FirebaseAuth.instance.currentUser;
    final userEmail = user?.email ?? "Sem e-mail";
    final userName = user?.displayName ?? "Estudante"; // Se tiver nome no Google

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Colors.black),
            accountName: Text(
              userName, 
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)
            ),
            accountEmail: Row(
              children: [
                const Icon(Icons.star, color: Colors.white, size: 16),
                const SizedBox(width: 4),
                const Text("5.0", style: TextStyle(fontWeight: FontWeight.bold)),
                const SizedBox(width: 15),
                Text(userEmail, style: const TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              // Se tiver foto do Google, puxa. Se não, ícone padrão.
              backgroundImage: user?.photoURL != null ? NetworkImage(user!.photoURL!) : null,
              child: user?.photoURL == null ? const Icon(Icons.person, size: 40, color: Colors.black) : null,
            ),
          ),
          _buildMenuItem(Icons.person_outline, 'Configuração de Perfil', onTap: () {}),
          _buildMenuItem(Icons.history, 'Atividade', onTap: () {}),
          _buildMenuItem(Icons.account_balance_wallet_outlined, 'UniRide Pay', onTap: () {}),
          _buildMenuItem(Icons.help_outline, 'Ajuda', onTap: () {}),
          _buildMenuItem(Icons.message_outlined, 'Mensagens', onTap: () {}),
          _buildMenuItem(Icons.security, 'Central de Segurança', onTap: () {}),
          _buildMenuItem(Icons.payment, 'Métodos de Pagamento', onTap: () {}),
          _buildMenuItem(Icons.settings_outlined, 'Configurações', onTap: () {}),
          const Divider(thickness: 1),
          _buildMenuItem(Icons.people_outline, 'Convide Amigos', onTap: () {}),
          _buildMenuItem(Icons.person_add_alt_1_outlined, 'Convide Motoristas', onTap: () {}),
          _buildMenuItem(Icons.drive_eta_outlined, 'Seja Motorista', onTap: () {}),
          
          const Divider(thickness: 1),
          // Botão de Logout adicionado aqui!
          _buildMenuItem(Icons.logout, 'Sair do UniRideX', color: Colors.red, onTap: () async {
            // Desloga e volta para o AuthGate (que vai mandar pro Login automaticamente)
            await AuthService().signOut();
          }),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title, {required VoidCallback onTap, Color color = Colors.black87}) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color)),
      onTap: onTap,
    );
  }
}
