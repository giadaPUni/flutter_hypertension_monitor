import 'package:flutter/material.dart'; 

class DashboardPage extends StatelessWidget {
    const DashboardPage({
        super.key, 
    }); 

    @override
    Widget build(BuildContext context) {

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'Hypertension Monitor',
                ), 
            ), 

            body: Center(

                child: Text(
                    'Dashboard', 

                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium,
                ), 
            ), 
        );
    }

}