let project = new Project('MountainBrew');
project.addSources('Sources');
project.addAssets('Assets/**');
project.addLibrary('Kha2D');
resolve(project);
