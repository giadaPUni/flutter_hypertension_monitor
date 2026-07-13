import 'package:flutter/material.dart'; 

class AddMeasurementPage extends StatelessWidget {

    const AddMeasurementPage({
        super.key,
    }); 

    @override
    Widget build(BuildContext context) {

        return Scaffold(

            appBar: AppBar(
                title: const Text(
                    'New Measurement', 
                ), 
            ), 

            body: const Center(
                child: Text(
                    'Add measurement',
                ), 
            ), 
        ); 
    }

}