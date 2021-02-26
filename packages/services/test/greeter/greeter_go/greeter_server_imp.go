package greeter_go

import (
	context "context"
	"fmt"
	"github.com/scryinfo/dot/dot"
	"github.com/scryinfo/dot/dots/grpc/gserver"
)

const GreeterServerImpTypeID = "c7b58321-ad66-41e6-937d-31cf4c6c1767"

type configGreeterServerImp struct {
	//todo add
}
type GreeterServerImp struct {
	ServerNobl gserver.ServerNobl `dot:""`
	conf       configGreeterServerImp
	//todo add
}

func (c *GreeterServerImp) SayHello(ctx context.Context, request *HelloRequest) (*HelloReply, error) {
	re := &HelloReply{}
	re.Message = fmt.Sprintf("replay %s", request.Name)
	return re, nil
}

//func (c *GreeterServerImp) Create(l dot.Line) error {
//
//}
//func (c *GreeterServerImp) Injected(l dot.Line) error {
//
//}
//func (c *GreeterServerImp) AfterAllInject(l dot.Line) {
//
//}

func (c *GreeterServerImp) Start(ignore bool) error {
	RegisterGreeterServer(c.ServerNobl.Server(), c)
	return nil
}

//func (c *GreeterServerImp) Stop(ignore bool) error {
//
//}
//
//func (c *GreeterServerImp) Destroy(ignore bool) error {
//
//}

//construct dot
func newGreeterServerImp(conf []byte) (dot.Dot, error) {
	dconf := &configGreeterServerImp{}

	//err := dot.UnMarshalConfig(conf, dconf)
	//if err != nil {
	//	return nil, err
	//}

	d := &GreeterServerImp{conf: *dconf}

	return d, nil
}

//GreeterServerImpTypeLives
func GreeterServerImpTypeLives() []*dot.TypeLives {
	tl := &dot.TypeLives{
		Meta: dot.Metadata{TypeID: GreeterServerImpTypeID, NewDoter: func(conf []byte) (dot.Dot, error) {
			return newGreeterServerImp(conf)
		}},
		Lives: []dot.Live{
			{
				LiveID:    GreeterServerImpTypeID,
				RelyLives: map[string]dot.LiveID{"ServerNobl": gserver.ServerNoblTypeID},
			},
		},
	}

	lives := []*dot.TypeLives{tl}
	lives = append(lives, gserver.ServerNoblTypeLives()...)

	return lives
}

//GreeterServerImpConfigTypeLive
func GreeterServerImpConfigTypeLive() *dot.ConfigTypeLive {
	paths := make([]string, 0)
	paths = append(paths, "")
	return &dot.ConfigTypeLive{
		TypeIDConfig: GreeterServerImpTypeID,
		ConfigInfo: &configGreeterServerImp{
			//todo
		},
	}
}
