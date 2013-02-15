#ifndef PARTICLE_H
#define PARTICLE_H

typedef float Vec3[3];

struct Plane
{
	Vec3 p;
	Vec3 n;
};

void print(Vec3 v)
{
	printf("[ %f , %f , %f ]\n", v[0], v[1], v[2]);
}

__device__
float dist(const Vec3 v1, const Vec3 v2)
{
	return sqrt((v2[0]-v1[0])*(v2[0]-v1[0]) + (v2[1]-v1[1])*(v2[1]-v1[1]) + (v2[2]-v1[2])*(v2[2]-v1[2]));
}

__device__
float dot(const Vec3 v1, const Vec3 v2)
{
	return v1[0]*v2[0] + v1[1]*v2[1]+ v1[2]*v2[2];
}

__device__
void norm(const Vec3 v, Vec3 *nv)
{
	Vec3 v0;
	float d;
	v0[0]=v0[1]=v0[2]=0;
	d = dist(v,v0);
	(*nv)[0]=v[0]/d;
	(*nv)[1]=v[1]/d;
	(*nv)[2]=v[2]/d;
}

void cross(const Vec3 a, const Vec3 b, Vec3 *res)
{
	(*res)[0] = a[1]*b[2]-a[2]*b[1];
	(*res)[1] = a[2]*b[0]-a[0]*b[2];
	(*res)[2] = a[0]*b[1]-a[1]*b[0];
}

__device__
float distPointToPlane(const Vec3 v, const Plane p)
{
	Vec3 dif;
	dif[0] = p.p[0]-v[0];
	dif[1] = p.p[1]-v[1];
	dif[2] = p.p[2]-v[2];
	return dot(p.n,dif);
} 

struct Particle
{
    Vec3 v;
    Vec3 nv;
    Vec3 p;
    float r;
    float m;
    bool willCollide;
    //Hit hit;
};

bool testCollision(const Particle *a, const Particle *b, float dt)
{
    return false;
}

void moveParticle(Particle *a, float dt)
{
    int i;
    for(i=0; i<3; i++)
        a->p[i] += a->v[i]*dt;
    
}

#endif
