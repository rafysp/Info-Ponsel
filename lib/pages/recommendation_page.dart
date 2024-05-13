import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:info_ponsel/model/recommendation_model.dart';
import 'package:provider/provider.dart';

class RecommendationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecommendationModel(),
      child: RecommendationPageContent(),
    );
  }
}

class RecommendationPageContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final model = Provider.of<RecommendationModel>(context, listen: true);

    return Scaffold(
      appBar: AppBar(
        title: Text('Rekomendasi Ponsel'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: model.budgetController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: 'Budget',
                  prefixText: 'IDR ',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  model.addPriority('');
                },
                icon: Icon(Icons.add),
                label: Text('Tambah Kebutuhan'),
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: model.selectedPriorities.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: TextEditingController(
                                  text: model.selectedPriorities[index]),
                              onChanged: (value) =>
                                  model.selectedPriorities[index] = value,
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(RegExp(
                                    r'[a-zA-Z\s]+')), // Hanya huruf dan spasi
                              ],
                              decoration: InputDecoration(
                                labelText: 'Kebutuhan ${index + 1}',
                                hintText: 'contoh: kamera, baterai, performa',
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () {
                              Provider.of<RecommendationModel>(context,
                                      listen: false)
                                  .removePriority(index);
                            },
                          ),
                        ],
                      ),
                      SizedBox(
                          height:
                              16), // Tambahkan SizedBox untuk memberikan jarak antara setiap kolom prioritas
                    ],
                  );
                },
              ),
              SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  Provider.of<RecommendationModel>(context, listen: false)
                      .getRecommendation(model.budgetController.text,
                          model.selectedPriorities, context);
                },
                icon: Icon(Icons.send),
                label: Text('Recommend'),
              ),
              SizedBox(height: 16),
              Consumer<RecommendationModel>(
                builder: (context, model, _) {
                  return model.isLoading
                      ? Center(child: CircularProgressIndicator())
                      : model.recommendationList.isNotEmpty
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  model.recommendationList.join('\n'),
                                ),
                                SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    model.clearRecommendation();
                                  },
                                  child: Text('Clear'),
                                ),
                              ],
                            )
                          : Container();
                },
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
