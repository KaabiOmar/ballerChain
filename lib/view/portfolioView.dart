import 'package:ballerchain/common/theme_helper.dart';
import 'package:flutter/material.dart';

class PortfolioPage extends StatelessWidget {
  final List<String> titles = ['Bitcoin', 'Etherium', 'Tether','BNB','USC COIN','XRP','Cardano','Doge'];
  final List<String> subtitles = ['£6.74', '0.04£', '0.0051£','2.03£','4.5£','0.091£','1.33£','0.0003£'];
  final List<String> imagePaths = ['assets/images/bit.png', 'assets/images/eth.png', 'assets/images/tet.png', 'assets/images/bnb.png', 'assets/images/usd.png', 'assets/images/xrp.png', 'assets/images/cardano.png', 'assets/images/doge.png'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/bgrnd.png',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 16.0),
              Text(
                'Total balance',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold,color: Colors.white70),
              ),
              SizedBox(height: 8.0),
               Container(
                decoration: ThemeHelper().buttonBoxDecoration(context),
                padding:
                EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Text(
                  '741.022£',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: 8,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.black26, // Couleur de fond
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          child: CircleAvatar(
                            backgroundImage: AssetImage(imagePaths[index]),
                          ),
                        ),
                        title: Text(titles[index],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.purple,
                          ),
                        ),
                        subtitle: Text(subtitles[index],

                          style: TextStyle(
                            color: Colors
                                .white70, // Couleur du texte du sous-titre
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

            ],
          ),
        ],
      ),
      appBar: AppBar(
        title: Text(
          'Portfolio',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                  'assets/images/bgrnd.png'), // Chemin de l'image
              fit: BoxFit.none, // Mode de redimensionnement de l'image
            ),
          ),
        ),

      ),

    );
  }
}
