class UpdateItemParameters {
  final int id;
  UpdateItemParameters(this.id);
    Map<String, dynamic> toJson() => {'id': id};

}
