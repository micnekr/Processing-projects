class Genome {
  float[] genes;
  public Genome(float[] genes) {
    this.genes = new float[genes.length];
    for (int i = 0; i < genes.length; i++) {
      this.genes[i] = genes[i];
    }
  }

  public Genome(int numOfGenes) {
    this.genes = new float[numOfGenes];
    for (int i = 0; i < numOfGenes; i++) {
      this.genes[i] = random(-1, 1);
    }
  }
}
